from sqlalchemy import Column, NUMERIC, VARCHAR, INTEGER, CHAR, ForeignKey, DATE, Integer, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from settings import settings_dw, settings_op
from sqlalchemy_utils import database_exists, create_database


def get_engine(settings):
    
    if settings['db'] == "prova":
        url = f"postgresql://{settings['user']}:{settings['psswd']}@{settings['host']}:{settings['port']}/{settings['db']}?options=-csearch_path%3Ddbo,relacional" 
    else:
        url = f"postgresql://{settings['user']}:{settings['psswd']}@{settings['host']}:{settings['port']}/{settings['db']}"
    
    if not database_exists(url):
        create_database(url)
    
    engine = create_engine(url, pool_size=50, echo=False)
    
    return engine

engine_op = get_engine(settings_op)
engine_dw = get_engine(settings_dw)

session_op = sessionmaker(bind=engine_op,autoflush=True)()
session_dw = sessionmaker(bind=engine_dw,autoflush=True)()

Base = declarative_base()
Base_dw = declarative_base()

class Produtos(Base):

    __tablename__ = 'produtos'

    idproduto = Column(INTEGER, primary_key=True)
    produto = Column(VARCHAR(100))
    preco = Column(NUMERIC(10,2))


class Vendedores(Base):

    __tablename__ = 'vendedores'

    idvendedor = Column(INTEGER, primary_key=True)
    nome = Column(VARCHAR(50))


class Clientes(Base):
    
    __tablename__ = 'clientes'

    idcliente = Column(INTEGER, primary_key=True)
    cliente = Column(VARCHAR(50))
    estado = Column(VARCHAR(2))
    sexo = Column(CHAR(1))
    status = Column(VARCHAR(50))


class Vendas(Base):
    
    __tablename__ = 'vendas'

    idvenda = Column(INTEGER, primary_key=True)
    idvendedor = Column(INTEGER, ForeignKey("vendedores.idvendedor"))
    idcliente = Column(INTEGER, ForeignKey("clientes.idcliente"))
    data = Column(DATE)
    total = Column(NUMERIC(10,2))


class Itensvenda(Base):

    __tablename__ = 'itensvenda'

    idproduto = Column(INTEGER, ForeignKey("produtos.idproduto"), primary_key=True)
    idvenda = Column(INTEGER, ForeignKey("vendas.idvenda"), primary_key=True)
    quantidade = Column(INTEGER)
    valorunitario = Column(NUMERIC(10,2))
    valortotal = Column(NUMERIC(10,2))
    desconto = Column(NUMERIC(10,2))

#-----------------------------------------------------------#
#------------------------DIMENSIONAL------------------------#
#-----------------------------------------------------------#

class DM_Cliente(Base_dw):

    __tablename__= 'dm_cliente'

    id_cliente = Column(INTEGER, primary_key=True)
    nome = Column(VARCHAR(50))
    estado = Column(VARCHAR(20))
    sexo = Column(CHAR(1))
    classe = Column(VARCHAR(50))

    def __init__(self, cliente : Clientes) -> None:
        super().__init__()
        self.id_cliente = cliente.idcliente
        self.nome = cliente.cliente
        self.estado = cliente.estado
        self.sexo = cliente.sexo
        self.classe = cliente.status


class DM_Produto(Base_dw):

    __tablename__ = 'dm_produto'

    id_produto = Column(INTEGER, primary_key=True)
    nome = Column(VARCHAR(100))
    classe = Column(CHAR(1))

    def __init__(self, produto : Produtos) -> None:
        super().__init__()
        self.id_produto = produto.idproduto
        self.nome = produto.produto
        if produto.preco < 500:
            self.classe = 'P'
        elif produto.preco < 3000:
            self.classe = 'M'
        else:
            self.classe = 'A'
    

class DM_Vendedor(Base_dw):

    __tablename__ = 'dm_vendedor'

    id_vendedor = Column(INTEGER, primary_key=True)
    nome = Column(VARCHAR(50))
    nivel = Column(CHAR(1))

    def __init__(self, vendedor : Vendedores, nivel : str) -> None:
        super().__init__()
        self.id_vendedor = vendedor.idvendedor
        self.nome = vendedor.nome
        self.nivel = nivel

class DM_Tempo(Base_dw):

    __tablename__ = 'dm_tempo'

    id_tempo = Column(Integer, primary_key=True)
    ano : str = Column(VARCHAR(4))
    trimestre = Column(CHAR(1))
    mes : str = Column(VARCHAR(20))
    dia : str = Column(VARCHAR(20))

    def __init__(self, vendas : Vendas, id: int) -> None:
        super().__init__()
        self.id_tempo = id
        self.ano = str(vendas.data.year)
        self.mes = str(vendas.data.month)
        self.dia = str(vendas.data.day)
        if int(self.mes) < 4:
            self.trimestre = 1
        elif int(self.mes) < 7:
            self.trimestre = 2
        elif int(self.mes) < 10:
            self.trimestre = 3
        else:
            self.trimestre = 4
      
        
class FT_Vendas(Base_dw):

    __tablename__ = 'tf_vendas'

    id_venda = Column(INTEGER, primary_key=True)
    id_tempo = Column(Integer, ForeignKey("dm_tempo.id_tempo"), primary_key=True)
    id_cliente = Column(INTEGER, ForeignKey("dm_cliente.id_cliente"), primary_key=True)
    id_produto = Column(INTEGER, ForeignKey("dm_produto.id_produto"), primary_key=True)
    id_vendedor = Column(INTEGER, ForeignKey("dm_vendedor.id_vendedor"), primary_key=True)
    valor_produto = Column(NUMERIC(10,2))
    valor_total_venda = Column(NUMERIC(10,2))
    desconto_total_venda = Column(NUMERIC(10,2))
    qtde_vendas = Column(INTEGER)

    def __init__(self, id_venda, id_tempo, id_cliente, id_produto, id_vendedor, valor_produto, valor_total_venda, desconto_total_venda, qtde_vendas ) -> None:
        super().__init__()
        self.id_venda= id_venda
        self.id_tempo = id_tempo
        self.id_cliente = id_cliente
        self.id_produto = id_produto
        self.id_vendedor= id_vendedor
        self.valor_produto = valor_produto
        self.valor_total_venda = valor_total_venda
        self.desconto_total_venda = desconto_total_venda
        self.qtde_vendas = qtde_vendas