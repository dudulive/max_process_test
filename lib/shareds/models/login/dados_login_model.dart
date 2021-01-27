class DadosLoginModel {
  String login;
  String token;
  int idEmpresa;
  int idUsuario;
  String dataExpiracao;
  int idPessoa;

  DadosLoginModel();

  DadosLoginModel.fromJson(Map<String, dynamic> json) {
    this.login = json['login'];
    this.token = json['token'];
    this.idEmpresa = json['idEmpresa'];
    this.idUsuario = json['idUsuario'];
    this.dataExpiracao = json['dataExpiracao'];
    this.idPessoa = json['idPessoa'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['login'] = this.login;
    data['token'] = this.token;
    data['idEmpresa'] = this.idEmpresa;
    data['idUsuario'] = this.idUsuario;
    data['dataExpiracao'] = this.dataExpiracao;
    data['idPessoa'] = this.idPessoa;
    return data;
  }
}
