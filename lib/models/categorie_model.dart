class CategorieModel {
  String categorieName;
  String imageAssetUrl;

  CategorieModel({
    required this.categorieName,
    required this.imageAssetUrl,
  });

  CategorieModel.named({
    this.categorieName = '',
    this.imageAssetUrl = '',
  });
}
