<!-- TOC -->

- [Book: Excel 2007 VBA Programmer's Reference](#book-excel-2007-vba-programmers-reference)
- [Basic](#basic)
- [String & Regex](#string--regex)
- [MsgBox](#msgbox)
- [Dim & ReDim](#dim--redim)
- [Sheets](#sheets)
- [Range & Cell](#range--cell)
- [ColorIndex Property](#colorindex-property)
- [Test cell empty](#test-cell-empty)
- [Find string & delete row](#find-string--delete-row)
- [Array](#array)
- [Filter](#filter)
- [Hyperlinks](#hyperlinks)
- [Time](#time)
- [XML parser](#xml-parser)
- [SQL](#sql)

<!-- /TOC -->

# Book: Excel 2007 VBA Programmer's Reference
http://i.msdn.microsoft.com/Aa199411.colorin%28en-us,office.10%29.gif

# Basic
sheets = worksheet + chart
function: can be used in cell
IIF = IF THEN ELSE

    ' Force explicit variable declaration.
    Option Explicit On

    'turns off all error handling for subsequent statements
    On Error Resume Next

    Dim owner_index As Integer 'default = 0


# String & Regex
    Sub Split_Cell_String()
        With ActiveSheet
            For r = 2 To 37
                s = .Range("B" & r).Value

                Set objRegExp_1 = CreateObject("vbscript.regexp")
                objRegExp_1.Global = True
                objRegExp_1.IgnoreCase = True
                objRegExp_1.Pattern = "[\d:]+"

                Set regExp_Matches = objRegExp_1.Execute(s)
                For Each m In regExp_Matches
                    .Cells(r, 6).Value = m
                    .Cells(r, 7).Value = objRegExp_1.Replace(s, "")
                Next
            Next
        End With
    End Sub

# MsgBox
    MsgBox(prompt[, buttons] [, title] [, helpfile, context])
    MsgBox prompt:="xxx" , title:=... , Msgbox Buttons:=vbOKOnly/vbOKCancel/vbAbortRetryIgnore.. (Note the COMMA)
    Answer = MsgBox(Prompt:=”Delete this record?”, Buttons:=vbYesNo + vbQuestion) (Note the PARENTHESES)
    If Answer = vbYes/vbNo/vb...
    UserName = InputBox(Prompt:=”Please enter your name”)

# Dim & ReDim
Dim advantage: preservation of capitalization.  
ReDim will re-initialize the array and destroy any data in it, unless you use the Preserve keyword.
It is necessary to declare sht as the generic Object type if you want to allow it to refer to different sheet types.

# Sheets
There is a Sheets collection in the Excel object model, but there is no Sheet object.

    With Workbooks.Add
        With .Worksheets.Add(After:=.Sheets(.Sheets.Count))
            .Name = “January”
            .Range(“A1”).Value = “Sales Data”
        End With
        .SaveAs Filename:=”JanSales.xlsx”
    End With

    icount = Worksheets.Count
    Worksheets(1).Copy After:=Worksheets(icount) // icount won't ++

# Range & Cell
    [A1] = 10
    Range(“B3:E10”).Select
    Range(“C5:Z100”).Activate ' C5 will be actived since it's within B3:E10
    ActiveCell.Offset(2, 0).EntireRow.Select
    Range(“A1”).End(xlDown)
    Range(“B3”, Range(“B3”).End(xlToRight).End(xlDown)).Select
    Range(“A1:B5,C6:D10,E11:F15”).Rows.Count ' return rows number of A1:B5

# ColorIndex Property
![](http://i.msdn.microsoft.com/Aa199411.colorin%28en-us,office.10%29.gif)  
Rows.Interior.ColorIndex = xlColorIndexNone

# Test cell empty
The IsEmpty function is the best way to test that a cell is empty.  
If you use If Cells(row,col) = “”, the test will be true for a formula that calculates a zero-length string.

    MsgBox Evaluate(“=ISBLANK(A1)”)
    MsgBox [ISBLANK(A1)]

# Find string & delete row
    column.find

    Sub DeleteRows2()
        Dim rngFoundCell As Range
        ‘Freeze screen
        Application.ScreenUpdating = False

        'Application.ScreenUpdating = False + workbook.open+close : open workbook in background
        ‘Find a cell containing Mangoes
        Set rngFoundCell = Range(“C:C”).Find(What:=”Mangoes”)

        ‘Keep looping until no more cells found
        Do Until rngFoundCell Is Nothing

        ‘Delete found cell row
        rngFoundCell.EntireRow.Delete

        ‘Find next
        Set rngFoundCell = Range(“C:C”).FindNext
        Loop
    End Sub

# Array
    For array_member = LBound(array) To UBound(array)
    For each array_member in array
    keywords_auto_route = Array("KMS, PK ", "GPS", "logo([^n]|$)")

# Filter
    Sheet.FilterMode = Data has been filtered?
    .Range("A1").AutoFilterMode = false
    .Range("A1").AutoFilter

# Hyperlinks
    With ActiveSheet
        .Hyperlinks.Add Anchor:=.Range("G17"), _
        Address:="", _
        SubAddress:="other_sheet!cell", _
        TextToDisplay:="TextToDisplay"
    End With

# Time
    format(date, "yyyy/mm/dd")  'TimeZone: http://www.cpearson.com/Zips/TimeZone.ZIP

    Dim TInfo As CTime
    Dim D As Double

    If TInfo Is Nothing Then
        Set TInfo = New CTime
    Else
        TInfo.Refresh
    End If

    today = Format(TInfo.GMT + 8 / 24, "yyyy/mm/dd") 'force to be +8:00

# XML parser
    Dim objXML As DOMDocument
    Set objXML = New DOMDocument

    strXML = ThisWorkbook.Path & "\xml\ferro_work_sbis_conf.xml"
    If Not objXML.Load(strXML) Then 'strXML is the string with XML
        Err.Raise objXML.parseError.ErrorCode, , objXML.parseError.reason
    End If

    download_sr_save_path = objXML.selectSingleNode("//name[text()='download_sr_save_path']").parentNode.selectSingleNode("path").Text

# SQL
    Dim conn_central As New Connection
    Dim rsSales As New Recordset
    conn_central.Open "Provider=Microsoft.Jet.OLEDB.4.0;" _
        & "Extended Properties=Excel 8.0;" _
        & "Data Source=" & wb_central

    Sql = "update [backlog$] as b inner join [Excel 8.0;Database=" & config.path_wb_owner & "].[Owner$] as o on (b.`Root Cause - Platforms Windows Level 1` = o.`Level 1 Classification`) and (b.`Root Cause - Platforms Windows Level 2` = o.`Level 2 Classification`) set b.`PFA Owner` = o.`PFA Owner` "
    rsSales.Open Sql, conn_central, adOpenKeyset, adLockBatchOptimistic

    conn_central.Execute Sql
    Set wks = Worksheets.Add

    For i = 0 To rsSales.Fields.count - 1
        wks.Cells(1, i + 1).Value = rsSales.Fields(i).Name
    Next

    wks.Range("A2").CopyFromRecordset rsSales
