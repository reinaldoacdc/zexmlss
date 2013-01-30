(* Simplistic interface for uniform workbook saving
   Bridge object template for different avemey.com
      export routines.

   (c) the Arioch, licensed under zLib license *)
unit zeSaveODS;

interface

implementation
uses zeSave, zexmlss, zeodfs, Types, StrUtils;

type TZxODSSaver = class(TZXMLSSave)
     protected
        function InternalSave: integer; override;
        class function FormatDescriptions: TStringDynArray; override;
end;

{ TZxODSSaver }

class function TZxODSSaver.FormatDescriptions: TStringDynArray;
begin
  Result := SplitString(
   '.ods*.fods*OASIS*OpenOffice*OpenOffice.org*'+
   'application/vnd.oasis.opendocument.spreadsheet*org.oasis.opendocument.spreadsheet*'+
   'OpenDocument*OpenDocument SpreadSheet*ISO/IEC 26300*ISO 26300', '*');
end;

function TZxODSSaver.InternalSave: integer;
begin
  Result := ExportXmlssToODFS( // todo
    fBook, FFile, GetPageNumbers, GetPageTitles, fConv, fCharSet, fBOM,
    false, FZipGen);
end;

initialization
    TZxODSSaver.Register;
//    TZXMLSSave.RegisterFormat(TZxODSSaver);
finalization
    TZxODSSaver.UnRegister;
//    TZXMLSSave.UnRegisterFormat(TZxODSSaver);
end.
