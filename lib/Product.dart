import 'package:flutter/material.dart';

class Product {
  final String title; // عنوان محصول
  final String fullPrice; // قیمت کامل
  final String price; // قیمت با تخفیف
  final String rating; // امتیاز محصول
  final Color backgroundColor; // رنگ پس‌زمینه
  final String strcolor;
  final Color color;
  final String img; // تصویر محصول
  final bool isAmazingOffer; // آیا تخفیف شگفت‌انگیز دارد؟
  final bool isTopProduct; // آیا جز محصولات برتر است؟
  final int stock; // موجودی محصول
  final int soldCount; // تعداد فروش محصول
  final double productScore; // امتیاز محصول
  final bool isLiked; // آیا محصول لایک شده است؟
  final String category; // دسته‌بندی محصول
  final ProductSpecs specs; // مشخصات محصول
  final int discount;
  late int quantity;

  // کانستراکتور اصلی
   Product({
    required this.title,
    required this.fullPrice,
    required this.price,
    required this.rating,
    required this.backgroundColor,
    required this.strcolor,
    required this.color,
    required this.img,
    required this.discount,
    required this.isAmazingOffer,
    required this.isTopProduct,
    required this.stock,
    required this.soldCount,
    required this.productScore,
    required this.isLiked,
    required this.category,
    required this.specs,
     required this.quantity,
  });

  // کانستراکتور ساده برای محصولات پایه
   Product.basic({
    required this.title,
    required this.price,
    required this.img,
    required this.discount,
    this.fullPrice = '',
    this.rating = '0',
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.color = const Color(0xFFFFFFFF),
    this.strcolor = "White",
    this.isAmazingOffer = false,
    this.isTopProduct = false,
    this.stock = 0,
    this.soldCount = 0,
    this.productScore = 0.0,
    this.isLiked = false,
    this.category = "Others",
     this.quantity = 0,
    this.specs = const ProductSpecs(phoneType: "", model: "", releaseDate: "", dimensions: "",features: [""]),
  });

  // کانستراکتور برای محصولات تخفیف شگفت‌انگیز
   Product.amazingOffer({
    required this.title,
    required this.fullPrice,
    required this.price,
    required this.img,
    required this.discount,
    this.rating = '0',
    this.backgroundColor = const Color(0xFFFFE0B2),
    this.color = const Color(0xFFFFFFFF),
    this.strcolor = "White",
    this.isAmazingOffer = true,
    this.isTopProduct = false,
    this.stock = 10,
    this.soldCount = 0,
    this.productScore = 0.0,
     this.quantity = 0,
    this.isLiked = false,
    this.category = "Others",
    this.specs = const ProductSpecs(phoneType: "", model: "", releaseDate: "", dimensions: "", features: [""]),
  });
}

class ProductSpecs {
  final String phoneType;
  final String model;
  final String releaseDate;
  final String dimensions;
  final List<String> features;

  const ProductSpecs({
    required this.phoneType,
    required this.features,
    required this.model,
    required this.releaseDate,
    required this.dimensions,
  });
}
