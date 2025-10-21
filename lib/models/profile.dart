class UserProfile {
  final int? id;
  final String? ucode;
  final String? name;
  final bool adminRole;
  final bool skipControls;
  final String? categoryId;
  final int? networkId;
  final String? crmCltCateg;

  UserProfile({
    this.id,
    this.ucode,
    this.name,
    this.adminRole = false,
    this.skipControls = false,
    this.categoryId,
    this.networkId,
    this.crmCltCateg,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      ucode: json['ucode'],
      name: json['name'],
      adminRole: json['adminRole'] ?? false,
      skipControls: json['skipControls'] ?? false,
      categoryId: json['categoryId'],
      networkId: json['networkId'],
      crmCltCateg: json['crmCltCateg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ucode': ucode,
      'name': name,
      'adminRole': adminRole,
      'skipControls': skipControls,
      'categoryId': categoryId,
      'networkId': networkId,
      'crmCltCateg': crmCltCateg,
    };
  }

  UserProfile copyWith({
    int? id,
    String? ucode,
    String? name,
    bool? adminRole,
    bool? skipControls,
    String? categoryId,
    int? networkId,
    String? crmCltCateg,
  }) {
    return UserProfile(
      id: id ?? this.id,
      ucode: ucode ?? this.ucode,
      name: name ?? this.name,
      adminRole: adminRole ?? this.adminRole,
      skipControls: skipControls ?? this.skipControls,
      categoryId: categoryId ?? this.categoryId,
      networkId: networkId ?? this.networkId,
      crmCltCateg: crmCltCateg ?? this.crmCltCateg,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'UserProfile[id=$id, name=$name]';
}
