class RegisterReponse {
	String? id;
	String? username;
	String? email;
	String? nombre;
	String? role;
	String? createdAt;
	String? token;

	RegisterReponse({
		this.id, 
		this.username, 
		this.email, 
		this.nombre, 
		this.role, 
		this.createdAt, 
		this.token, 
	});

	factory RegisterReponse.fromJson(Map<String, dynamic> json) {
		return RegisterReponse(
			id: json['id'] as String?,
			username: json['username'] as String?,
			email: json['email'] as String?,
			nombre: json['nombre'] as String?,
			role: json['role'] as String?,
			createdAt: json['createdAt'] as String?,
			token: json['token'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'username': username,
				'email': email,
				'nombre': nombre,
				'role': role,
				'createdAt': createdAt,
				'token': token,
			};
}
