// import 'package:t_store/features/personalization/data/models/products/product_attribute_upload_model.dart';
// import 'package:t_store/features/personalization/data/models/products/product_upload_model.dart';
// import 'package:t_store/features/personalization/data/models/products/product_variation_upload_model.dart';
// import 'package:t_store/features/shop/features/all_brands/data/models/brand_model.dart';
// import 'package:t_store/features/shop/features/home/data/models/banner_model.dart';
// import 'package:t_store/features/shop/features/home/data/models/category_model.dart';
// import 'package:t_store/utils/constants/enums.dart';
// import 'package:t_store/utils/constants/images_strings.dart';

// class DummyData {
//   // List of all categories
//   static final List<CategoryModel> categories = [
//     CategoryModel(
//         id: '1', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
//     CategoryModel(
//         id: '5',
//         name: 'Furniture',
//         image: TImages.furnitureIcon,
//         isFeatured: true),
//     CategoryModel(
//         id: '2',
//         name: 'Electronics',
//         image: TImages.electronicsIcon,
//         isFeatured: true),
//     CategoryModel(
//         id: '3', name: 'Clothing', image: TImages.clothIcon, isFeatured: true),
//     CategoryModel(
//         id: '4', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
//     CategoryModel(
//         id: '6', name: 'Shoes', image: TImages.shoeIcon, isFeatured: true),
//     CategoryModel(
//         id: '7',
//         name: 'Cosmetics',
//         image: TImages.cosmeticsIcon,
//         isFeatured: true),
//     CategoryModel(
//         id: '14',
//         name: 'Jewelery',
//         image: TImages.jeweleryIcon,
//         isFeatured: true),

//     //subCategories
//     CategoryModel(
//         id: '8',
//         name: 'Sport Shoes',
//         parentId: '1',
//         image: TImages.cosmeticsIcon,
//         isFeatured: false),
//     CategoryModel(
//         id: '9',
//         name: 'Track suits',
//         parentId: '1',
//         image: TImages.cosmeticsIcon,
//         isFeatured: false),
//     CategoryModel(
//         id: '10',
//         name: 'Sports Equipments',
//         parentId: '1',
//         image: TImages.cosmeticsIcon,
//         isFeatured: false),

//     //Furniture
//     CategoryModel(
//         id: '11',
//         name: 'Kitchen Furniture',
//         parentId: '5',
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     CategoryModel(
//         id: '12',
//         name: 'Bedroom Furniture',
//         parentId: '5',
//         image: TImages.furnitureIcon,
//         isFeatured: false),
//     CategoryModel(
//         id: '13',
//         name: 'Office Furniture',
//         parentId: '5',
//         image: TImages.furnitureIcon,
//         isFeatured: false),

//     // electornics
//     CategoryModel(
//         id: '14',
//         name: 'Mobiles',
//         parentId: '2',
//         image: TImages.electronicsIcon,
//         isFeatured: false),
//     CategoryModel(
//         id: '15',
//         name: 'Laptops',
//         parentId: '2',
//         image: TImages.electronicsIcon,
//         isFeatured: false),

//     CategoryModel(
//         id: '16',
//         name: 'Shirts',
//         parentId: '3',
//         image: TImages.electronicsIcon,
//         isFeatured: false),
//   ];

//   static final List<BannerModel> banners = [
//     BannerModel(
//         id: '1', image: TImages.banner3, targetScreen: '/order', active: false),
//   ];

//   static final List<ProductUploadModel> products = [
//     ProductUploadModel(
//       stock: 20,
//       id: '001',
//       price: 135,
//       title: 'Green Nike sports shoe',
//       sku: 'ABR4568',
//       salePrice: 30,
//       description: 'This is a Product description for Green Nike sports shoe',
//       categoryId: '1',
//       productType: ProductType.variable.toString(),
//       images: [
//         TImages.productImage21,
//         TImages.productImage22,
//         TImages.productImage23
//       ],
//       thumbnail: TImages.productImage21,
//       isFeatured: true,
//       brand: BrandModel(
//         id: '6',
//         name: 'Nike',
//         image: TImages.nikeLogo,
//         isFeatured: true,
//         productCount: 2,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Green', 'Black', 'Red'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Size',
//           values: ['EU 30', 'EU 32', 'EU 34'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage1,
//           price: 134,
//           salePrice: 122.6,
//           stock: 34,
//           attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
//           description: 'Green Nike sports shoe - EU 34',
//         ),
//         ProductVariationUploadModel(
//           id: '2',
//           image: TImages.productImage23,
//           price: 132,
//           stock: 15,
//           attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
//           description: 'Black Nike sports shoe - EU 32',
//         ),
//         ProductVariationUploadModel(
//           id: '3',
//           image: TImages.productImage23,
//           price: 234,
//           stock: 0,
//           attributeValues: {'Color': 'Red', 'Size': 'EU 30'},
//           description: 'Red Nike sports shoe - EU 30',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 10,
//       id: '002',
//       price: 250,
//       title: 'Blue Denim Jacket',
//       sku: 'JCK1234',
//       salePrice: 45,
//       description: 'A stylish blue denim jacket for all occasions.',
//       categoryId: '2',
//       productType: ProductType.variable.toString(),
//       images: [
//         TImages.productImage3,
//         TImages.productImage64,
//         TImages.productImage65
//       ],
//       thumbnail: TImages.productImage3,
//       isFeatured: false,
//       brand: BrandModel(
//         id: '7',
//         name: 'Levi’s',
//         image: TImages.acerlogo,
//         isFeatured: true,
//         productCount: 3,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Size',
//           values: ['S', 'M', 'L', 'XL'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Material',
//           values: ['Denim'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage3,
//           price: 240,
//           salePrice: 220,
//           stock: 5,
//           attributeValues: {'Size': 'M', 'Material': 'Denim'},
//           description: 'Medium Blue Denim Jacket',
//         ),
//         ProductVariationUploadModel(
//           id: '2',
//           image: TImages.productImage64,
//           price: 260,
//           stock: 3,
//           attributeValues: {'Size': 'L', 'Material': 'Denim'},
//           description: 'Large Blue Denim Jacket',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 30,
//       id: '003',
//       price: 400,
//       title: 'Adidas Running Shoes',
//       sku: 'ADR5678',
//       salePrice: 120,
//       description: 'Lightweight and comfortable running shoes from Adidas.',
//       categoryId: '1',
//       productType: ProductType.variable.toString(),
//       images: [
//         TImages.productImage19,
//         TImages.productImage20,
//         TImages.productImage21
//       ],
//       thumbnail: TImages.productImage19,
//       isFeatured: true,
//       brand: BrandModel(
//         id: '8',
//         name: 'Adidas',
//         image: TImages.adidasLogo,
//         isFeatured: true,
//         productCount: 5,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Blue', 'Black', 'White'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Size',
//           values: ['EU 40', 'EU 42', 'EU 44'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage19,
//           price: 390,
//           salePrice: 360,
//           stock: 20,
//           attributeValues: {'Color': 'Blue', 'Size': 'EU 42'},
//           description: 'Adidas Running Shoes - Blue - EU 42',
//         ),
//         ProductVariationUploadModel(
//           id: '2',
//           image: TImages.productImage20,
//           price: 410,
//           stock: 10,
//           attributeValues: {'Color': 'Black', 'Size': 'EU 44'},
//           description: 'Adidas Running Shoes - Black - EU 44',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 15,
//       id: '004',
//       price: 999,
//       title: 'Apple iPhone 14 Pro',
//       sku: 'APL1313',
//       salePrice: 899,
//       description: 'The latest iPhone with advanced features.',
//       categoryId: '3',
//       productType: 'Electronics',
//       images: [
//         TImages.productImage51,
//         TImages.productImage52,
//       ],
//       thumbnail: TImages.productImage51,
//       isFeatured: true,
//       brand: BrandModel(
//         id: '9',
//         name: 'Apple',
//         image: TImages.appleLogo,
//         isFeatured: false,
//         productCount: 10,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Graphite', 'Gold', 'Silver'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Storage',
//           values: ['128GB', '256GB', '512GB'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage51,
//           price: 979,
//           salePrice: 949,
//           stock: 7,
//           attributeValues: {'Color': 'Graphite', 'Storage': '256GB'},
//           description: 'Apple iPhone 13 Pro - Graphite - 256GB',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 50,
//       id: '005',
//       price: 80,
//       title: 'Puma T-Shirt',
//       sku: 'PUM12345',
//       salePrice: 60,
//       description: 'Casual Puma T-Shirt available in various colors.',
//       categoryId: '4',
//       productType: 'Clothing',
//       images: [
//         TImages.productImage60,
//         TImages.productImage61,
//         TImages.productImage62
//       ],
//       thumbnail: TImages.productImage60,
//       isFeatured: true,
//       brand: BrandModel(
//         id: '10',
//         name: 'Puma',
//         image: TImages.pumaLogo,
//         isFeatured: true,
//         productCount: 8,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Red', 'Yellow', 'Green'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Size',
//           values: ['S', 'M', 'L', 'XL'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage60,
//           price: 75,
//           salePrice: 65,
//           stock: 25,
//           attributeValues: {'Color': 'Red', 'Size': 'M'},
//           description: 'Puma T-Shirt - Red - M',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 35,
//       id: '006',
//       price: 60,
//       title: 'Zara Men’s Shirt',
//       sku: 'ZRM1234',
//       salePrice: 50,
//       description: 'Premium quality men’s shirt from Zara.',
//       categoryId: '4',
//       productType: 'Clothing',
//       images: [
//         TImages.productImage70,
//         TImages.productImage71,
//         TImages.productImage72
//       ],
//       thumbnail: TImages.productImage70,
//       isFeatured: false,
//       brand: BrandModel(
//         id: '11',
//         name: 'Zara',
//         image: TImages.zaraLogo,
//         isFeatured: true,
//         productCount: 7,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['White', 'Blue', 'Black'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Size',
//           values: ['M', 'L', 'XL'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage70,
//           price: 55,
//           salePrice: 45,
//           stock: 12,
//           attributeValues: {'Color': 'White', 'Size': 'L'},
//           description: 'Zara Men’s Shirt - White - L',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 20,
//       id: '007',
//       price: 320,
//       title: 'Kenwood Mixer',
//       sku: 'KEN12345',
//       salePrice: 280,
//       description: 'High-performance kitchen mixer by Kenwood.',
//       categoryId: '5',
//       productType: 'Appliances',
//       images: [
//         TImages.productImage74,
//         TImages.productImage75,
//         TImages.productImage76,
//         TImages.productImage77,
//       ],
//       thumbnail: TImages.productImage74,
//       isFeatured: false,
//       brand: BrandModel(
//         id: '12',
//         name: 'Kenwood',
//         image: TImages.kenwoodLogo,
//         isFeatured: true,
//         productCount: 15,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Silver', 'Black'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Power',
//           values: ['500W', '1000W'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage70,
//           price: 310,
//           salePrice: 290,
//           stock: 8,
//           attributeValues: {'Color': 'Silver', 'Power': '1000W'},
//           description: 'Kenwood Mixer - Silver - 1000W',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 25,
//       id: '008',
//       price: 200,
//       title: 'Herman Miller Office Chair',
//       sku: 'HMOC123',
//       salePrice: 180,
//       description: 'Ergonomic office chair for maximum comfort.',
//       categoryId: '6',
//       productType: 'Furniture',
//       images: [
//         TImages.productImage39,
//         TImages.productImage40,
//       ],
//       thumbnail: TImages.productImage39,
//       isFeatured: false,
//       brand: BrandModel(
//         id: '13',
//         name: 'Herman Miller',
//         image: TImages.hermanMillerLogo,
//         isFeatured: true,
//         productCount: 10,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Black', 'Gray'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Material',
//           values: ['Mesh', 'Leather'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage64,
//           price: 190,
//           salePrice: 170,
//           stock: 15,
//           attributeValues: {'Color': 'Black', 'Material': 'Mesh'},
//           description: 'Herman Miller Office Chair - Black - Mesh',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 40,
//       id: '009',
//       price: 550,
//       title: 'IKEA Wardrobe',
//       sku: 'IKW1234',
//       salePrice: 500,
//       description: 'Spacious and elegant wardrobe from IKEA.',
//       categoryId: '6',
//       productType: 'Furniture',
//       images: [
//         TImages.productImage24,
//         TImages.productImage25,
//         TImages.productImage26,
//         TImages.productImage27,
//       ],
//       thumbnail: TImages.productImage24,
//       isFeatured: false,
//       brand: BrandModel(
//         id: '14',
//         name: 'IKEA',
//         image: TImages.ikeaLogo,
//         isFeatured: true,
//         productCount: 20,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['White', 'Brown'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Material',
//           values: ['Wood', 'MDF'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage24,
//           price: 520,
//           salePrice: 490,
//           stock: 10,
//           attributeValues: {'Color': 'White', 'Material': 'Wood'},
//           description: 'IKEA Wardrobe - White - Wood',
//         ),
//       ],
//     ),
//     ProductUploadModel(
//       stock: 60,
//       id: '010',
//       price: 500,
//       title: 'Acer Aspire Laptop',
//       sku: 'ACR12345',
//       salePrice: 450,
//       description: 'Affordable and reliable laptop from Acer.',
//       categoryId: '3',
//       productType: 'Electronics',
//       images: [
//         TImages.productImage47,
//         TImages.productImage48,
//         TImages.productImage49,
//         TImages.productImage50,
//       ],
//       thumbnail: TImages.productImage47,
//       isFeatured: true,
//       brand: BrandModel(
//         id: '15',
//         name: 'Acer',
//         image: TImages.acerlogo,
//         isFeatured: true,
//         productCount: 5,
//       ),
//       productAttributes: [
//         ProductAttributeUploadModel(
//           name: 'Color',
//           values: ['Black', 'Silver'],
//         ),
//         ProductAttributeUploadModel(
//           name: 'Storage',
//           values: ['256GB SSD', '512GB SSD'],
//         ),
//       ],
//       productVariations: [
//         ProductVariationUploadModel(
//           id: '1',
//           image: TImages.productImage51,
//           price: 480,
//           salePrice: 430,
//           stock: 25,
//           attributeValues: {'Color': 'Silver', 'Storage': '512GB SSD'},
//           description: 'Acer Aspire Laptop - Silver - 512GB SSD',
//         ),
//       ],
//     ),
//   ];

//   static List<BrandModel> brands = [
//     BrandModel(
//       id: '1',
//       name: 'Nike',
//       image: TImages.nikeLogo,
//       isFeatured: true,
//       productCount: 2,
//     ),
//     BrandModel(
//       id: '2',
//       name: 'Adidas',
//       image: TImages.adidasLogo,
//       isFeatured: true,
//       productCount: 5,
//     ),
//     BrandModel(
//       id: '3',
//       name: 'Apple',
//       image: TImages.appleLogo,
//       isFeatured: false,
//       productCount: 10,
//     ),
//     BrandModel(
//       id: '4',
//       name: 'Puma',
//       image: TImages.pumaLogo,
//       isFeatured: true,
//       productCount: 8,
//     ),
//     BrandModel(
//       id: '5',
//       name: 'Zara',
//       image: TImages.zaraLogo,
//       isFeatured: true,
//       productCount: 7,
//     ),
//     BrandModel(
//       id: '6',
//       name: 'Kenwood',
//       image: TImages.kenwoodLogo,
//       isFeatured: true,
//       productCount: 15,
//     ),
//     BrandModel(
//       id: '7',
//       name: 'Herman Miller',
//       image: TImages.hermanMillerLogo,
//       isFeatured: false,
//       productCount: 10,
//     ),
//     BrandModel(
//       id: '8',
//       name: 'IKEA',
//       image: TImages.ikeaLogo,
//       isFeatured: false,
//       productCount: 20,
//     ),
//   ];
// }
