unit Sortirovka;

interface

uses Winapi.Windows, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,SysUtils,Variants,Sort_UpDown,Sort_StrTypepas;

                                         //��� ��������������� ���������� ����������
type TMyArray=array of variant;          //��� ������� - ���������� � ��� ����� ��������
                                         //��� ��� ������

Procedure SortVstavkami(var a:TMyArray);
procedure Delay(X: Cardinal);
function ShowBasicVariantType(varVar: Variant):string;
procedure SortirovkaPoVozr (var a:TMyArray);
procedure SortirovkaPoYbiv (var a:TMyArray);
procedure SortirovkaPoDline( var a:TMyArray);

implementation

procedure Delay(X: Cardinal);
Var t: cardinal;
begin
 t:=GetTickCount;
 While (GetTickCount <= t + X) Do
  Begin
    { ������������ ��������� }
   Application.ProcessMessages;
    { ����� ����� ������������� ������� ������ ������� }
   Sleep(1);
  End; {While}
End;

procedure SortirovkaPoVozr(var a:TMyArray);
var i,j:integer;
    buf:variant;
begin
for i := 1 to (length(a)-1) do begin
      buf:=a[i];                           //���������� i-��� �������
      j:=i-1;                              //������ ���������� ������� �� ���������� �����
      while ((buf>a[j]) and (j>-1)) do begin  //���� ��������� ������ �������� � �����,
        a[j+1]:=a[j];                      //��� ��������������� �����
        j:=j-1;                            //������� ����������,������� buf
      end;
      a[j+1]:=buf;                           //������ buf �� ��� ����� �����
    end;
end;

procedure SortirovkaPoYbiv(var a:TMyArray);
var i,j:integer;
    buf:variant;
begin
for i := 1 to (length(a)-1) do begin
      buf:=a[i];                           //���������� i-��� �������
      j:=i-1;                              //������ ���������� ������� �� ���������� �����
      while ((buf<a[j]) and (j>-1)) do begin  //���� ��������� ������ �������� � �����,
        a[j+1]:=a[j];                      //��� ��������������� �����
        j:=j-1;                            //������� ����������,������� buf
      end;
      a[j+1]:=buf;                           //������ buf �� ��� ����� �����
    end;
end;


procedure SortirovkaPoDline(var a:TMyArray);
var i,j:integer;
    buf:variant;
begin
  for i := 1 to (length(a)-1) do begin
      buf:=a[i];                           //���������� i-��� �������
      j:=i-1;                              //������ ���������� ������� �� ���������� �����
      while ((length(buf)>length(a[j])) and (j>-1)) do begin  //���� ��������� ������ �������� � �����,
        a[j+1]:=a[j];                      //��� ��������������� �����
        j:=j-1;                            //������� ����������,������� buf
      end;
      a[j+1]:=buf;                           //������ buf �� ��� ����� �����
    end;
end;


function ShowBasicVariantType(varVar: Variant):string;
var
  basicType  : Integer;
  typestring : string;
begin
  // ��������� ��������� ���� Variant :
  basicType := (VarType(varVar) );
  // ��������� ������ ��� ������������ ����
  case basicType of
   varEmpty      : typeString := 'varEmpty';
    varNull      : typeString := 'varNull';
    varSmallInt  : typeString := 'varSmallInt';
    varInteger   : typeString := 'varInteger';
    varSingle    : typeString := 'varSingle';
    varDouble    : typeString := 'varDouble';
    varCurrency  : typeString := 'varCurrency';
    varDate      : typeString := 'varDate';
    varOleStr    : typeString := 'varOleStr';
    varDispatch  : typeString := 'varDispatch';
    varError     : typeString := 'varError';
    varBoolean   : typeString := 'varBoolean';
    varVariant   : typeString := 'varVariant';
    varUnknown   : typeString := 'varUnknown';
    varByte      : typeString := 'varByte';
    varWord      : typeString := 'varWord';
    varLongWord  : typeString := 'varLongWord';
    varInt64     : typeString := 'varInt64';
    varStrArg    : typeString := 'varStrArg';
    varString    : typeString := 'varString';
    varAny       : typeString := 'varAny';
    varTypeMask  : typeString := 'varTypeMask';
  end;
  result:=typestring;
end;

Procedure SortVstavkami(var a:TMyArray);
var
  i,j:integer;
  buf:variant;
  s:string;
begin
  s:='��������� ��� ������ '+ShowBasicVariantType(a[0]);
  showmessage(s);
  if ((ShowBasicVariantType(a[1])='varEmpty') or (ShowBasicVariantType(a[1])='varNull')) then begin
    showmessage('������������ ��� ������');
    exit;
  end;
  if ((ShowBasicVariantType(a[1])='varDouble')or (ShowBasicVariantType(a[1])='varSingle')or(ShowBasicVariantType(a[1])='varInteger') or (ShowBasicVariantType(a[1])='varBoolean')) then begin
    Sort_UpDown.Form2.Show;
    Delay(5000) ;                         //�������� 5 ���
    case Sort_UpDown.Form2.RadioGroup1.ItemIndex  of
        1: SortirovkaPoVozr(a);
        0: SortirovkaPoYbiv(a);
      end;
    exit;
  end
  else
    if  length(a)>0 then begin
      Sort_StrTypePas.Form3.Show;
      Delay(5000);
      case Sort_StrTypePas.Form3.RadioGroup1.ItemIndex  of
        1: begin
             Sort_UpDown.Form2.Show;
             delay(5000);
             case Sort_StrTypepas.Form3.RadioGroup1.ItemIndex of
               0: SortirovkaPoVozr(a);
               1: SortirovkaPoYbiv(a);
             end;
           end;
        0: SortirovkaPoDline(a);
      end;
    end;
end;


end.

