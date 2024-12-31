import 'package:flutter/material.dart';
import 'package:untitled/Product.dart';

class Product {
  final String title; // عنوان محصول
  final String fullPrice; // قیمت کامل
  final String price; // قیمت با تخفیف
  final String rating; // امتیاز محصول
  final Color backgroundColor; // رنگ پس‌زمینه
  final String img; // تصویر محصول
  final bool isAmazingOffer; // آیا تخفیف شگفت‌انگیز دارد؟
  final bool isTopProduct; // آیا جز محصولات برتر است؟
  final int stock; // موجودی محصول
  final int soldCount; // تعداد فروش محصول
  final double productScore; // امتیاز محصول
  final bool isLiked; // آیا محصول لایک شده است؟

  // کانستراکتور اصلی
  const Product({
    required this.title,
    required this.fullPrice,
    required this.price,
    required this.rating,
    required this.backgroundColor,
    required this.img,
    required this.isAmazingOffer,
    required this.isTopProduct,
    required this.stock,
    required this.soldCount,
    required this.productScore,
    required this.isLiked,
  });

  // کانستراکتور ساده برای محصولات پایه
  const Product.basic({
    required this.title,
    required this.price,
    required this.img,
    this.fullPrice = '',
    this.rating = '0',
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.isAmazingOffer = false,
    this.isTopProduct = false,
    this.stock = 0,
    this.soldCount = 0,
    this.productScore = 0.0,
    this.isLiked = false,
  });

  // کانستراکتور برای محصولات تخفیف شگفت‌انگیز
  const Product.amazingOffer({
    required this.title,
    required this.fullPrice,
    required this.price,
    required this.img,
    this.rating = '0',
    this.backgroundColor = const Color(0xFFFFE0B2),
    this.isAmazingOffer = true,
    this.isTopProduct = false,
    this.stock = 10,
    this.soldCount = 0,
    this.productScore = 0.0,
    this.isLiked = false,
  });
}
