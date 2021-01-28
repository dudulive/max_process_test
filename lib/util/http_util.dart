class HttpUtil {
  static String tratarRetornoComMensagemPadrao(e, String mensagemErro) {
    try {
      var json = e.toJson();
      print('Erro: ' + json.toString());
      switch (e.getStatusCode()) {
        case 404:
          return mensagemErro;
        case 400:
          return json != "" ? json : mensagemErro;
        case 500:
          if (json != "Read timed out") {
            return 'Sistema temporariamente indisponível. Tente novamente mais tarde.';
          }
          return mensagemErro;
        case 204:
          return mensagemErro;
        default:
          return 'Sistema temporariamente indisponível. Tente novamente mais tarde.';
      }
    } catch (e) {
      print(e);
      return 'Sistema temporariamente indisponível. Tente novamente mais tarde.';
    }
  }
}
