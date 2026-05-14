import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "SearchFieldTests"
    width: 400
    height: 400
    visible: true

    KaakaoSearchField {
        id: testSearch
        anchors.centerIn: parent
        placeholderText: "Search..."
    }

    function test_search_clearing() {
        testSearch.text = "Hello"
        compare(testSearch.text, "Hello", "Text should be set")
        
        testSearch.text = ""
        compare(testSearch.text, "", "Text should be cleared")
    }

    function test_search_signal() {
        var emitCount = 0
        var connection = function(query) {
            emitCount++
        }
        testSearch.searchRequested.connect(connection)

        testSearch.searchRequested("test")
        compare(emitCount, 1, "searchRequested signal should be caught")
        
        testSearch.searchRequested.disconnect(connection)
    }
}
