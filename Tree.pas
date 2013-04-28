unit Tree;

interface

uses Dialogs,SysUtils;

type
  TInfo=integer;
  PNode=^TNode;

  TNode=record
    inf: TInfo;
    left,right,parent: PNode;
  end;

TTree=class
  public
    constructor Create;
    destructor  Destroy;
    procedure   Insert(newinfo:TInfo);
    function    Search(sinfo:TInfo):PNode;
  private
    Root:PNode;
    procedure   Insert0(var Node:PNode;var parent:PNode;newinfo:TInfo);
    function    Search0(Node:PNode;sinfo:TInfo):PNode;
    procedure   CreateFile;
    procedure   AddStringInFile(str:string);
    procedure   DeleteSymbol;
    procedure   Clear;
end;


implementation

constructor TTree.Create;
begin
  inherited Create;
end;

procedure TTree.Clear;
begin
  Root:=Nil;
end;

destructor TTree.Destroy;
begin
  inherited Destroy;
end;


procedure TTree.CreateFile;
var f:textfile;
begin
  assignfile(f,'../../Tree.txt');
  Rewrite(f);
  writeln (f,'digraph Tree {');
  writeln(f,'}');
  closefile(f);
end;

procedure TTree.AddStringInFile(str:string);
var f,f2:textfile;
    s:string;
begin
  DeleteSymbol;
  assignfile(f,'../../Tree.txt');
  append(f);
  writeln(f,str);
  writeln(f,'}');
  closefile(f);
end;

procedure TTree.DeleteSymbol;
var f,f2: textfile;
    s: string;
begin
  assignfile(f,'../../Tree.txt');
  assignfile(f2,'../../BufTree.txt');
  reset(f);
  rewrite(f2);
  while not eof(f) do begin
    readln(f,s);
    if not EOF (f) then writeln(f2,s);
  end;
  closefile(f);
  closefile(f2);
  deletefile('../../Tree.txt');
  renamefile('../../BufTree.txt','../../Tree.txt');
end;

procedure TTree.Insert(newinfo: TInfo);
var b:PNode;
begin
  b:=nil;
  Insert0(Root,b,newinfo);
end;

procedure TTree.Insert0(var Node:PNode; var parent:PNode; newinfo:TInfo);
var p: PNode;
    s: string;
begin
  if Node=nil then
  begin
    if Root=nil then
      CreateFile;
    new (p);
    p.inf:=newinfo;
    p.left:=nil;
    p.right:=nil;
    if Root = nil then p.parent:=nil else p.parent:=parent;
    Node:=p;
    if parent <> nil then begin
      s:=IntToStr(Node.parent.inf)+'->'+IntToStr(Node^.inf);
      AddStringInFile(s);
    end;
  end
  else
  if ((newInfo<node.inf) or (newinfo=node.inf)) then begin
    parent:=Node;
    insert0(Node.left,parent,newinfo);
  end
  else begin
    parent:=Node;
    insert0(Node.right,parent,newinfo);
  end;
end;


function TTree.Search(sinfo:TInfo):PNode;
begin
  result:=Search0(Root,sinfo);
end;

function TTree.Search0(Node:PNode;sinfo:TInfo):PNode;
begin
  if Node.inf=sinfo then result:=Node
  else
    if Node.inf<sinfo then
      search0(node.right,sinfo)
    else
      search0(node.left,sinfo);
  if result=nil then showmessage('Такого элемента нет');

end;





end.
