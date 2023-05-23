import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

showBackgroudImageProvider(String url) {
  return CachedNetworkImageProvider(url);
}

showBackgroudImage(String url) {
  return CachedNetworkImage( imageUrl: url,);
}


showSnakBar(BuildContext context,String msg){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}