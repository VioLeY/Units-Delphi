unit SortirovkaVstavkami;

interface

                                         //��� ��������������� ���������� ����������
type TMyArray=array of variant;          //��� ������� - ���������� � ��� ����� ��������
                                         //��� ��� ������

Procedure SortVstavkami(var a:TMyArray);

implementation

Procedure SortVstavkami(var a:TMyArray);
var
  i,j:integer;
  buf:integer;
begin
  for i := 1 to length(a)-1 do begin
    buf:=a[i];                           //���������� i-��� �������
    j:=i-1;                              //������ ���������� ������� �� ���������� �����
    while ((buf>a[j]) and (j>-1)) do begin  //���� ��������� ������ �������� � �����,
      a[j+1]:=a[j];                      //��� ��������������� �����
      j:=j-1;                            //������� ����������,������� buf
    end;
    a[j+1]:=buf;                           //������ buf �� ��� ����� �����
  end;
end;


end.
