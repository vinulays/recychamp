import 'package:recychamp/screens/Community/bloc/posts_event.dart';
import 'package:test/test.dart';

void main() {
  group('PostEvent', () {
    group('FetchPostsEvent', () {
      test('instances of FetchPostsEvent should be equal', () {
        print('Running test for FetchPostsEvent');
        expect(FetchPostsEvent(), FetchPostsEvent());
        print('Test for FetchPostsEvent completed. Test passed!');
      });
    });

    group('AddPostEvent', () {
      test(
          'instances of AddPostEvent should be equal if their formData is equal',
          () {
        final formData1 = {'title': 'Post 1', 'content': 'Content 1'};
        final formData2 = {'title': 'Post 1', 'content': 'Content 1'};
        expect(AddPostEvent(formData1), AddPostEvent(formData2));
      });
    });
  });
}
