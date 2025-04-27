import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dashboard_carousel_provider.g.dart';

@riverpod
List<String> dashboardCarouselProvider(Ref ref) {
  return [
    "https://udb.ac.id/storage/app/uploads/public/640/020/ee4/640020ee44703197599835.jpg",
    "https://udb.ac.id/storage/app/uploads/public/640/021/d0a/640021d0a1726934716799.jpg",
    "https://udb.ac.id/storage/app/uploads/public/640/01d/f82/64001df82e373207319957.jpg",
    "https://udb.ac.id/storage/app/uploads/public/640/020/b2c/640020b2c54b2835778375.jpg",
    "https://udb.ac.id/storage/app/uploads/public/640/022/1b5/6400221b54a88568503914.jpg",
    "https://fikom.udb.ac.id/storage/app/uploads/public/61c/d6f/212/61cd6f21283ac350531290.jpg",
    "https://udb.ac.id/storage/app/uploads/public/640/021/7b0/6400217b0313f593669146.jpg",
    "https://udb.ac.id/storage/app/uploads/public/64a/fa2/6ae/64afa26ae31e3359999617.jpg",
    "https://udb.ac.id/storage/app/uploads/public/64a/fa5/919/64afa5919efbc699036598.jpg",
  ];
}
