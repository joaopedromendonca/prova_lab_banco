from inspect import Traceback
from models import (Produtos, 
                    Vendas, 
                    Itensvenda, 
                    Clientes, 
                    Vendedores, 
                    DM_Cliente, 
                    DM_Produto, 
                    DM_Tempo, 
                    DM_Vendedor, 
                    FT_Vendas, 
                    session_op,
                    session_dw,
                    engine_op,
                    engine_dw,
                    Base_dw)

def extract_op():
    
    try:
        vendas_dict = {
            'Produtos' : [p for p in session_op.query(Produtos).all()],
            'Vendas' : [v for v in session_op.query(Vendas).all()],
            'Itensvenda' : [ iv for iv in session_op.query(Itensvenda).all()],
            'Clientes' : [c for c in session_op.query(Clientes).all()],
            'Vendedores' : [v for v in session_op.query(Vendedores).all()],
        }
    except Exception as e:
        Traceback(e)
        
    return vendas_dict

def transform(v_dict):
    
    # workaround pro autoincremento que não está funcionando no orm
    id_tempo_increment = 0
    
    try:
        
        print("Transformando produtos")
        for produto in v_dict['Produtos']:
            dm_p = DM_Produto(produto)
            session_dw.merge(dm_p)
        
        print("Transformando clientes")
        for cliente in v_dict['Clientes']:
            dm_cli = DM_Cliente(cliente)
            session_dw.merge(dm_cli)
        
        print("Transformando vendedores")
        vendedor : Vendedores
        for vendedor in v_dict['Vendedores']:
            
            # Faz a soma total das vendas históricas do vendedor para determinar o nível
            soma_nivel = 0
            
            _venda : Vendas
            for _venda in v_dict['Vendas']:
                if _venda.idvendedor == vendedor.idvendedor:
                    soma_nivel += _venda.total
            
            if soma_nivel < 200000:
                nivel = '1'
            elif soma_nivel < 300000:
                nivel = '2'
            else:
                nivel = '3'                
                    
            dm_vend = DM_Vendedor(vendedor=vendedor, nivel=nivel)
            session_dw.merge(dm_vend)
        
        session_dw.commit()
        
        print("Transformando vendas")
        _qtde_vendas = len(v_dict['Vendas'])
        
        venda : Vendas
        for venda in v_dict['Vendas']:            
            
            dm_tempo = DM_Tempo(venda,id_tempo_increment)
            id_tempo_increment += 1
            session_dw.merge(dm_tempo)
            
            _id_tempo = dm_tempo.id_tempo
            
            cli : Clientes
            for cli in v_dict['Clientes']:
                if cli.idcliente == venda.idcliente:
                    _id_cliente = cli.idcliente
            
            vendedor : Vendedores
            for vendedor in v_dict['Vendedores']:
                if vendedor.idvendedor == venda.idvendedor:
                    _id_vendedor = vendedor.idvendedor
            
            _desconto_total = 0
            iv : Itensvenda
            for iv in v_dict['Itensvenda']:
                if iv.idvenda == venda.idvenda:
                    _id_produto = iv.idproduto
                    _val_produto = iv.valorunitario
                    _desconto_total += iv.desconto
                    
                    _v = FT_Vendas(venda.idvenda, _id_tempo,
                                    _id_cliente, _id_produto,
                                    _id_vendedor, _val_produto,
                                    venda.total, _desconto_total,
                                    _qtde_vendas)
                    print("Id venda:"+ str(_v.id_venda)+"/400")
                    session_dw.merge(_v)

        session_dw.commit()
        
    except Exception as e:
        session_dw.rollback()
        Traceback(e)
    

if __name__ == '__main__':
    
    print("Começou extração")
    v_dict = extract_op()
    print("Fim extração")
    Base_dw.metadata.create_all(bind=engine_dw)
    print("Começou transformação")
    transform(v_dict=v_dict)
    print("Terminou")