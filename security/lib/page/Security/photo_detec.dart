import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoPage extends StatefulWidget {
  final String photoPath;
  final String photoCaption;
  final String authorName;
  final String authorAvatarUrl;

  const PhotoPage({
    Key? key,
    required this.photoPath,
    required this.photoCaption,
    required this.authorName,
    required this.authorAvatarUrl,
  }) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}


class _PhotoPageState extends State<PhotoPage> {
  late String _photoUrl;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _loadPhotoUrl();
  }

  Future<void> _loadPhotoUrl() async {
    // Load the photo URL from Firebase Storage
    Reference ref = storage.ref().child(widget.photoPath);
    String photoUrl = await ref.getDownloadURL();
    setState(() {
      _photoUrl = photoUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.photoCaption ?? ''),
      ),
      body: _photoUrl != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Display the photo
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: _photoUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                // Display the author's name and avatar (if available), and the photo caption
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.authorName != null)
                        Row(
                          children: [
                            if (widget.authorAvatarUrl != null)
                              CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(widget.authorAvatarUrl),
                              ),
                            SizedBox(width: 8.0),
                            Text(widget.authorName),
                          ],
                        ),
                      SizedBox(height: 16.0),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.photoCaption ?? ''),
                      ),
                    ],
                  ),
                ),
              ],
            )
          // Display a loading indicator while the photo URL is being loaded
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
