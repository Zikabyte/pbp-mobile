// Unit tests for ApiClient: request shape (method, path, headers, body)
// and success/error handling for the project and auth endpoints.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_mobile/core/services/api_client.dart';
import 'package:portfolio_mobile/features/projects/models/project.dart';

void main() {
  group('ApiClient.getProjects', () {
    test('parses a list of projects from a 200 response', () async {
      final client = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/api/v1/projects/');
        return http.Response(
          jsonEncode([
            {
              'id': 'uuid-1',
              'title': 'Portfolio Site',
              'description': 'My site',
              'tech_stack': 'web-development',
              'project_url': 'https://example.com',
              'project_image_url': '',
            },
          ]),
          200,
        );
      });
      final apiClient = ApiClient(client: client, baseUrl: 'http://test.local');

      final projects = await apiClient.getProjects();

      expect(projects, hasLength(1));
      expect(projects.first.title, 'Portfolio Site');
      expect(projects.first.techStack, 'web-development');
    });

    test('throws ApiException on a non-2xx response', () async {
      final client = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });
      final apiClient = ApiClient(client: client, baseUrl: 'http://test.local');

      expect(apiClient.getProjects(), throwsA(isA<ApiException>()));
    });
  });

  group('ApiClient.createProject', () {
    test(
      'sends a POST with the token header and the serialized project',
      () async {
        final client = MockClient((request) async {
          expect(request.method, 'POST');
          expect(request.url.path, '/api/v1/projects/');
          expect(request.headers['Authorization'], 'Token test-token');
          expect(request.headers['Content-Type'], contains('application/json'));

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['title'], 'New Project');
          expect(body.containsKey('id'), isFalse);

          return http.Response(jsonEncode({...body, 'id': 'uuid-2'}), 201);
        });
        final apiClient = ApiClient(
          client: client,
          baseUrl: 'http://test.local',
        );

        final created = await apiClient.createProject(
          const Project(
            title: 'New Project',
            description: 'Desc',
            techStack: 'general',
            projectUrl: 'https://example.com',
          ),
          token: 'test-token',
        );

        expect(created.id, 'uuid-2');
        expect(created.title, 'New Project');
      },
    );

    test('throws ApiException with the status code on failure', () async {
      final client = MockClient((request) async {
        return http.Response('{"detail": "Forbidden"}', 403);
      });
      final apiClient = ApiClient(client: client, baseUrl: 'http://test.local');

      try {
        await apiClient.createProject(
          const Project(
            title: 'x',
            description: 'x',
            techStack: 'general',
            projectUrl: 'https://example.com',
          ),
          token: 'test-token',
        );
        fail('expected an ApiException');
      } on ApiException catch (e) {
        expect(e.statusCode, 403);
      }
    });
  });

  group('ApiClient.obtainToken', () {
    test('returns the token from a successful login', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/v1/auth/token/');
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['username'], 'zidane');
        expect(body['password'], 'secret');
        return http.Response('{"token": "abc123"}', 200);
      });
      final apiClient = ApiClient(client: client, baseUrl: 'http://test.local');

      final token = await apiClient.obtainToken('zidane', 'secret');

      expect(token, 'abc123');
    });
  });

  group('ApiClient.logout', () {
    test('sends the Authorization header to the logout endpoint', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/v1/auth/logout/');
        expect(request.headers['Authorization'], 'Token abc123');
        return http.Response('', 204);
      });
      final apiClient = ApiClient(client: client, baseUrl: 'http://test.local');

      await apiClient.logout(token: 'abc123');
    });
  });
}
