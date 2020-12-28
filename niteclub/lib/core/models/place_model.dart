
class PlaceModel {
  String fireId;
  int id;
  String Name;
  String ImgRef;
  int AveragePrice;
  int Cover;
  int Rate;
  String Email;
  String PublicEmail;
  double Latitud;
  double Longitud;
  String Music;
  String Phone;
  String Type;
  Map<String, dynamic> Menu;
  Map<String, dynamic> Address;
  Map<String, dynamic> Schudule;

  PlaceModel({ this.fireId, this.id, this.Name, this.ImgRef, this.AveragePrice,
    this.Cover, this.Rate, this.Email, this.PublicEmail, this.Latitud, this.Longitud,
    this.Phone, this.Music, this.Type, this.Menu, this.Address, this.Schudule
  });

  PlaceModel.fromFire(Map<String, dynamic> snapshot, String id) :
        fireId = id ?? '',
        id = snapshot['id'] ?? '',
        Name = snapshot['Name'] ?? '',
        ImgRef = snapshot['ImgRef'] ?? '',
        AveragePrice = snapshot['AveragePrice'] ?? '',
        Cover = snapshot['Cover'] ?? '',
        Rate = snapshot['Rate'] ?? '',
        Email = snapshot['Email'] ?? '',
        PublicEmail = snapshot['email'] ?? '',
        Latitud = snapshot['Latitud'] ?? '',
        Longitud = snapshot['Longitud'] ?? '',
        Phone = snapshot['Phone'] ?? '',
        Music = snapshot['Music'] ?? '',
        Type = snapshot['Type'] ?? '',
        Menu = snapshot['Menu'] ?? '',
        Address = snapshot['Address'] ?? '',
        Schudule = snapshot['Schudule'] ?? '';

  toJson() {
    return {
      "fireId": fireId,
      "id": id,
      "Name": Name,
      "ImgRef": ImgRef,
      "AveragePrice": AveragePrice,
      "Cover": Cover,
      "Rate": Rate,
      "Email": Email,
      "PublicEmail": PublicEmail,
      "Latitud": Latitud,
      "Longitud": Longitud,
      "Phone": Phone,
      "Music": Music,
      "Type": Type,
      "Menu": Menu,
      "Address": Address,
      "Schudule": Schudule,
    };
  }

  toPlace() {
    return {
      "fireId": fireId,
      "id": id,
      "name": Name,
      "ImgRef": ImgRef,
      "AveragePrice": AveragePrice,
      "Cover": Cover,
      "Rate": Rate,
      "Email": Email,
      "PublicEmail": PublicEmail,
      "Latitud": Latitud,
      "Longitud": Longitud,
      "Phone": Phone,
      "Music": Music,
      "Type": Type,
    };
  }

  Map<String, dynamic> toMap(){
    return {
      "fire": fireId,
      "id": id,
      "name": Name,
      "ImgRef": ImgRef,
      "AveragePrice": AveragePrice,
      "Cover": Cover,
      "Rate": Rate,
      "Email": Email,
      "PublicEmail": PublicEmail,
      "Latitud": Latitud,
      "Longitud": Longitud,
      "Phone": Phone,
      "Music": Music,
      "Type": Type,
      "Menu": Menu,
      "Address": Address,
      "Schudule": Schudule,
    };
  }

  PlaceModel.fromMap(Map<String, dynamic> Modelmap) {
    fireId = Modelmap['fireId'];
    id = Modelmap['id'];
    Name = Modelmap['name'];
    ImgRef = Modelmap['ImgRef'];
    AveragePrice = Modelmap['AveragePrice'];
    Cover = Modelmap['Cover'];
    Rate = Modelmap['Rate'];
    Email = Modelmap['Email'];
    PublicEmail = Modelmap['PublicEmail'];
    Latitud = Modelmap['Latitud'];
    Longitud = Modelmap['Longitud'];
    Phone = Modelmap['Phone'];
    Music = Modelmap['Music'];
    Type = Modelmap['Type'];
    Menu = Modelmap['Menu'];
    Address = Modelmap['Address'];
    Schudule = Modelmap['Schudule'];
  }

}