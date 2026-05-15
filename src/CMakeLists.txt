set_source_files_properties(Theme.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(Kaakao
    URI Kaakao
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    DEPENDENCIES Qt5Compat.GraphicalEffects
    QML_FILES
        Button.qml
        Theme.qml
        KaakaoWindow.qml
        KaakaoLabel.qml
        KaakaoDialog.qml
        KaakaoTextField.qml
        KaakaoFocusRing.qml
        KaakaoCheckBox.qml
        KaakaoRadioButton.qml
        KaakaoSegmentedControl.qml
        KaakaoToolBar.qml
        KaakaoToolButton.qml
        KaakaoSidebar.qml
        KaakaoTextArea.qml
        KaakaoComboBox.qml
        KaakaoSlider.qml
        KaakaoProgressBar.qml
        KaakaoSearchField.qml
        KaakaoDisclosureTriangle.qml
        KaakaoListView.qml
        KaakaoListDelegate.qml
        KaakaoTableView.qml
        KaakaoTableRowDelegate.qml
        KaakaoTableColumn.qml
)

target_link_libraries(Kaakao PRIVATE Qt6::Core5Compat Qt6::ShaderTools)
