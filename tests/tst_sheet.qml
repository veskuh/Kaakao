import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "SheetTests"
    width: 400
    height: 400
    visible: true

    Component {
        id: sheetComp
        KaakaoSheet {
            title: "Test Sheet"
            text: "This is a sheet body content."
        }
    }

    function test_sheet_properties() {
        let sheet = createTemporaryObject(sheetComp, null)
        verify(sheet, "Sheet created successfully")
        compare(sheet.title, "Test Sheet")
        compare(sheet.text, "This is a sheet body content.")
        compare(sheet.opened, false, "Should be closed initially")
    }
}
