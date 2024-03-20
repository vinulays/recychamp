import 'package:recychamp/models/article_model.dart';

// final List<Article> articlelNature = [
//   Article(
//     articleImage:
//         "https://s3-alpha-sig.figma.com/img/bf0a/f157/c9067d914d70d537ff6c0f457ba9f61e?Expires=1710720000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EVo1nSQqBV4ea6t06kjosWFaI02~AqjrQdMoBWU1ehw~2kUXixd1OU4OhnbmizlMa~2x1f1WDIcVkiOGWxwxGJ8lLc-Uf3j7Q9xO7uUB3EGZVlDGAmIYvNYh8ZY5z-sYnxye0RKIDUdj0Xe~xN~OrEqOARFBkoR-FUL~3j6axfMNwE7ye2nGDGuPVuN~ApYPDnQ2e8TvvzXe4EkNh86~CUtQemw3OpLKrZgwrIamj-bWjK57A02Bd0Rrsi0Jpv09ab~J236kiXmhQcLXFvV~WtNQ3g4Ge6CNBbJADhiciZapPV6bsejLRci-KXqL3aOk2D8~~yusCEWrNIbreUgtvA__",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.',
//     // modifiedDate: DateTime(2022, 3, 4),
//     articleType: "ssds",
// //     content: ''' Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//   ),
//   Article(
//     articleImage:
//         "https://s3-alpha-sig.figma.com/img/c03d/f0c9/c47a7b83105709ca8b85f10e93505636?Expires=1710720000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=YDKuy8gHrPzDTznehxeAgnuYz9adgGusUw~wfNqvPnnZsTB7IR0csNVWtpySUzmFMKMtEYGW2QGvk~1AMIAAvVO7B0XsY2qqmRi6PxqtSuZpeZbb16FN0hSax-JQfFQaAZ0fYm~OM9BH3feT9ZuLw4tO59xLXoxNEYbG-s25f5tAxNJGEdt7fe3SZV5oh8A26sQPaikk1zvcRCmJc5uB6-u7t135swiwRLt7x8vWcppK5lhWmJANj2H~5POAxkGslXIBaLeFfKm4fCQq4TC4QpPPWBbilOWsEW0WX7BEhMHZsueE1vyFK57f6sRuVtIdG~Q1JTbS~QsKuQS2fSLiVQ__",
//     articleTitle: "Photographing Nature",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
//     // modifiedDate: DateTime(2020, 10, 4),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim,
// // justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   ),
//   Article(
//     articleImage:
//         "https://s3-alpha-sig.figma.com/img/bf0a/f157/c9067d914d70d537ff6c0f457ba9f61e?Expires=1710720000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EVo1nSQqBV4ea6t06kjosWFaI02~AqjrQdMoBWU1ehw~2kUXixd1OU4OhnbmizlMa~2x1f1WDIcVkiOGWxwxGJ8lLc-Uf3j7Q9xO7uUB3EGZVlDGAmIYvNYh8ZY5z-sYnxye0RKIDUdj0Xe~xN~OrEqOARFBkoR-FUL~3j6axfMNwE7ye2nGDGuPVuN~ApYPDnQ2e8TvvzXe4EkNh86~CUtQemw3OpLKrZgwrIamj-bWjK57A02Bd0Rrsi0Jpv09ab~J236kiXmhQcLXFvV~WtNQ3g4Ge6CNBbJADhiciZapPV6bsejLRci-KXqL3aOk2D8~~yusCEWrNIbreUgtvA__",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.',
// //     modifiedDate: DateTime(2012, 3, 14),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   )
// ];

// List<Article> articlePlants = [
//   Article(
//     articleImage:
//         "https://th.bing.com/th/id/OIP.bNrYm7IpKhwTyyFjbNwhFgHaE8?rs=1&pid=ImgDetMain",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
// //     modifiedDate: DateTime(2020, 8, 10),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   ),
//   Article(
//     articleImage:
//         "https://th.bing.com/th/id/OIP.bNrYm7IpKhwTyyFjbNwhFgHaE8?rs=1&pid=ImgDetMain",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
// //     modifiedDate: DateTime(2022, 5, 4),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   ),
//   Article(
//     articleImage:
//         "https://th.bing.com/th/id/OIP.bNrYm7IpKhwTyyFjbNwhFgHaE8?rs=1&pid=ImgDetMain",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
// //     modifiedDate: DateTime(2022, 3, 4),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   ),
// ];

// List<Article> articleTrees = [
//   Article(
//     articleImage:
//         "https://www.aplustopper.com/wp-content/uploads/2019/11/Tree-Essay.jpg",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
// //     modifiedDate: DateTime(2022, 3, 4),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   ),
//   Article(
//     articleImage:
//         "https://th.bing.com/th/id/OIP.bNrYm7IpKhwTyyFjbNwhFgHaE8?rs=1&pid=ImgDetMain",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
// //     modifiedDate: DateTime(2022, 3, 4),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet,
// // consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: 'aaa',
//   ),
//   Article(
//     articleImage:
//         "https://th.bing.com/th/id/OIP.bNrYm7IpKhwTyyFjbNwhFgHaE8?rs=1&pid=ImgDetMain",
//     articleTitle: "The Wonders of Geology",
//     description:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. ddddddd',
// //     modifiedDate: DateTime(2022, 10, 4),
// //     content: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit.
// // Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat
// // ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero.
// // Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat ante

// // Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Se
// // d posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et est libero. Sed posuere, tortor sit amet cursus dignissim, justo quam consequat anteLorem ipsum dolor sit amet, consectetur adipiscing elit.
// // ''',
//     articleType: "ssds",
//   ),
// ];
