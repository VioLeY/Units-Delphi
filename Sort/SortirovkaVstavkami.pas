unit SortirovkaVstavkami;

interface

                                         //для универсальности сортировки используем
type TMyArray=array of variant;          //тип вариант - фактически в его можно записать
                                         //все что угодно

Procedure SortVstavkami(var a:TMyArray);

implementation

Procedure SortVstavkami(var a:TMyArray);
var
  i,j:integer;
  buf:integer;
begin
  for i := 1 to length(a)-1 do begin
    buf:=a[i];                           //запоминаем i-тый элемент
    j:=i-1;                              //ставим снутренний бегунок на предыдущий номер
    while ((buf>a[j]) and (j>-1)) do begin  //ищем положение нашего элемента в левой,
      a[j+1]:=a[j];                      //уже отсортированной части
      j:=j-1;                            //сдвигая элелементы,большие buf
    end;
    a[j+1]:=buf;                           //ставим buf на его новое место
  end;
end;


end.
