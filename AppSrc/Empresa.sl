Use Windows.pkg
Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cEMPRESADataDictionary.dd

Object oEmpresa_sl is a dbModalPanel
    Set Label to "Pesquisar Empresa"
    Set Size to 140 417
    Set Location to 4 5

    Object oDD is a cEMPRESADataDictionary        
    End_Object
    
    Set Main_DD to oDD
    Set Server  to oDD

    Object oSelList is a cDbCJGridPromptList
        Set Size to 110 397
        Set Location to 6 6
        Set peAnchors to anAll
        Set peUpdateMode to umPromptCustom
        Set pbMultipleSelection to False
        
        Object oColCNPJ is a cDbCJGridColumn
            Entry_Item EMPRESA.CNPJ_EMPRESA
            Set psCaption to "CNPJ / CPF"
            Set piWidth to 125
        End_Object

        Object oColNome is a cDbCJGridColumn
            Entry_Item EMPRESA.NOME_EMPRESA
            Set psCaption to "Nome do empreendimento/empresa"
            Set piWidth to 300
        End_Object

        Object oColStatus is a cDbCJGridColumn
            Set psCaption to "Status"
            Set piWidth to 80
            Set peHeaderAlignment to xtpAlignmentLeft
            
            Procedure OnSetCalculatedValue String ByRef sValue
                Move (GetDescricaoVT(Empresa_Status_VT, EMPRESA.STATUS)) to sValue
            End_Procedure
        End_Object
    End_Object

    Object oOk is a Button
        Set Label to "&OK"
        Set Location to 119 5
        Procedure OnClick
            Send Ok of oSelList
        End_Procedure
    End_Object

    Object oCancel is a Button
        Set Label to "&Cancelar"
        Set Location to 119 107
        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure
    End_Object

    Object oSearch_bn is a Button
        Set Label to "&Procurar"
        Set Location to 119 56
        Procedure OnClick
            Send Search of oSelList
        End_Procedure
    End_Object

End_Object