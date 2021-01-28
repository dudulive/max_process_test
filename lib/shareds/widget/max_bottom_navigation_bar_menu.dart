import 'package:flutter/material.dart';
import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:max_process_test/resources/values/ui_color.dart';

// ignore: must_be_immutable
class MaxBottomNavigationBarMenu extends StatelessWidget {
  BuildContext context;
  int selectedIndex;

  MaxBottomNavigationBarMenu({@required context, selectedIndex}) {
    this.context = context;
    this.selectedIndex = selectedIndex;
  }

  buttonMenu(BuildContext context, int index) {
    this.selectedIndex = index;
    if (selectedIndex == 1) {
      UsuarioDAO usuarioDAO = new UsuarioDAO();
      usuarioDAO.deletarTodos(context).then((value) {
        Navigator.of(context).pushNamed('/login');
      });
    }
    if (selectedIndex == 0) {
      Navigator.of(context).pushNamed('/listagem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.list,
              size: 60,
              color: UIColor.ACCENT_COLOR,
            ),
          ),
          title: Text(
            'Listagem',
            style: TextStyle(color: UIColor.ACCENT_COLOR),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(right: 10),
            child:
                Icon(Icons.exit_to_app, size: 60, color: UIColor.ACCENT_COLOR),
          ),
          title: Text(
            'Sair',
            style: TextStyle(color: UIColor.ACCENT_COLOR),
          ),
        ),
      ],
      currentIndex: this.selectedIndex ?? 0,
      fixedColor:
          this.selectedIndex != null ? UIColor.PRIMARY_COLOR : Colors.grey[600],
      onTap: (index) {
        buttonMenu(context, index);
      },
    );
  }
}
