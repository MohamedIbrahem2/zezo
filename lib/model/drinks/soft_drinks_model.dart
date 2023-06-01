class SoftDrinksModel {
  String? name, pic, oldPrice, currentPrice;

  SoftDrinksModel({this.name, this.pic, this.currentPrice, this.oldPrice});

  SoftDrinksModel.fromjson(map) {
    name = map['name'];
    pic = map['pic'];
    oldPrice = map['oldprice'];
    currentPrice = map['currentprice'];
  }
}
