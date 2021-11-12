import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'pt_BR': {
      'character_page_appbar_title': 'Personagens',
      'character_new_appbar_title': 'Novo Persongem',
      'character_edit_appbar_title': 'Editar Personagem',
      'character_remove_tab_title': 'Excluir persongaem',
      'character_edit_tab_title': 'Editar personagem',
      'character_add_image_container': 'Clique para adicionar uma foto',
      'character_name_input': "Nome",
      'character_description_input': "Descrição",
      'character_save_button': "Salvar",
      'change_locale': 'Mudar idioma para Inglês',
      'character_reset_button': 'Resetar Personagens'
    },
    'en_US': {
      'character_page_appbar_title': 'Characters',
      'character_new_appbar_title': 'New Character',
      'character_edit_appbar_title': 'Edit Character',
      'character_remove_tab_title': 'Delete character',
      'character_edit_tab_title': 'Edit character',
      'character_add_image_container': 'Click to add a photo',
      'character_name_input': "Name",
      'character_description_input': "Description",
      'character_save_button': "Save",
      'change_locale': 'Change the language to Portugues',
      'character_reset_button': 'Reset Characters'
    },
  };

}