unit HashLib;

interface
uses Queue,Dialogs,SysUtils;

const SizeHashTable=10;

type


TElement=record
  Info  : TMYQueue;
  empty : boolean;
end;

THashTable=class
  public
    constructor Create;
    destructor  Destroy;
    procedure   Add(Newinfo:TInfo);
    function    Find(FindInfo:TInfo):Integer;
    procedure   Delete(DelInfo:TInfo);
    procedure   ShowTable;
  private
    Size    :   Integer;
    Elements:   array of TElement;
    procedure   Add0(var Elements:array of TElement; NewInfo:TInfo);
    procedure   Delete0(var Elements:array of TElement;DelInfo:TInfo);
    procedure   DeleteHead(var Element:TElement);
    procedure   DeleteN(var Element:TElement;number:integer);
    function    HashKey (info :TInfo):integer;
end;


implementation

constructor THashTable.Create;
var i:integer;
begin
  Size:=0;
  setlength(Elements,SizeHashTable);
  for I := 0 to (length(Elements)-1) do
  begin
    Elements[i].empty:=true;
  end;
end;

destructor THashTable.Destroy;
var
  I: Integer;
  p:TInfo;
begin
  for I := 0 to length(Elements) do
    if not Elements[i].empty then begin
      while Elements[i].Info.isAviable do p:=Elements[i].Info.Get;
      Elements[i].empty:=true;
    end;
  Size:=0;
end;

procedure THashTable.Add(Newinfo: TInfo);
begin
  Add0(Elements,Newinfo);
end;

procedure THashTable.Add0(var Elements:array of TElement; Newinfo:TInfo);
var k:integer; p:TMyQueue;
begin
  k:=HashKey(Newinfo);
  if Elements[k].empty then begin
    p:=TMyQueue.Create;
    Elements[k].Info:=p;
    Elements[k].Info.Add(Newinfo);
    Elements[k].empty:=false;
    Size:=Size+1;
  end
  else begin
  Elements[k].info.Add(newinfo);
  Size:=Size+1;
  end;
end;

function THashTable.HashKey(info: TInfo):integer;
var sm:int64;i:integer;
begin
  {result:=length(info); }
  Sm := 0;
  For I := 1 To Length(info)-1 Do
    Sm := (Sm + Ord(info[i])) * 31;
  Result := (Sm + Ord(info[Length(info)])) mod SizeHashTable;
end;

function THashTable.Find(FindInfo: TInfo):integer;
var i,k:Integer; buf:TInfo;
begin
  i:=HashKey(FindInfo);
  result:=-1;
  if not Elements[i].empty then begin
    k:=1;
    while Elements[i].Info.isAviable do begin
      buf:=Elements[i].Info.GetValue(k);
      if buf=FindInfo then
      begin
        result:=i;
        exit;
      end
      else
        k:=k+1;
    end;
  end;
end;

procedure THashTable.Delete(DelInfo: TInfo);
begin
  Delete0(Elements,DelInfo);
end;

procedure THashTable.Delete0(var Elements: array of TElement; DelInfo: TInfo);
var i,n:integer;
    k:TInfo;
    ok:boolean;
    s:TInfo;
begin
  i:=Find(DelInfo);
  n:=1;
  if i<>-1 then begin
    while Elements[i].Info.isAviable do begin
      k:=Elements[i].Info.GetValue(n);
      if k=DelInfo then
        if ((n=1)and Elements[i].Info.isAviable) then begin
          s:='';
          try begin
            s:=Elements[i].Info.GetValue(2);
            s:=Elements[i].Info.Get;
            exit;
          end;
          except
            DeleteHead(Elements[i])
          end;
        end
        else begin
          DeleteN(Elements[i],n);
          exit;
        end
      else
        n:=n+1;
    end;
  end;
  Size:=Size-1;
end;

procedure THashTable.DeleteHead(var Element:TElement);
begin
  Element.Info.Destroy;
  Element.empty:=true;
end;

procedure THashTable.DeleteN(var Element:TElement; number:integer);
begin
  Element.info.Delete(number);
end;

procedure THashTable.ShowTable;
var i,n:integer; s:string;
begin
  s:='';
  for I := 0 to sizehashtable-1 do
    if not Elements[i].empty then begin
      n:=1;
      while Elements[i].Info.isAviable do
        try
          s:=s+' '+Elements[i].Info.GetValue(n)+' ';
          n:=n+1;
        except
          break;
        end;
    end;
  s:=s+#13#10+'Размер теблицы='+IntToStr(Size);
    showmessage(s);
end;

end.
