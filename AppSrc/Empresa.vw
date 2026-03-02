Use Windows.pkg
Use DFClient.pkg
Use Util.pkg
Use Empresa.sl

Open EMPRESA
Open CONTATO_EMPRESA
Open ENDERECO_EMPRESA

Deferred_View Activate_oEmpresa for ;
Object oEmpresa is a View
    Set Size to 194 416
    Set Location to 3 4
    Set Label to "Cadastro de Empresas - SC"
    
    Object oFrmCNPJ is a Form
        Set Label to "CNPJ:"
        Set Location to 5 70
        Set Size to 13 86
        Set Prompt_Button_Mode to PB_PromptOn
        
        Procedure Prompt
            Clear EMPRESA
            Move (Value(Self)) to sGlobalCNPJEmpresa
            Send Popup to oEmpresa_sl
            Send pTelaFromBuffer
        End_Procedure
        
        Procedure Exiting
            If (Value(Self) <> "") Begin
                If (Length(Value(Self))<>14) Begin
                    Send Info_Box "Tamanho do CNPJ inválido!" "Aviso"
                    Set Value of Self to ""
                    Procedure_Return
                End
                
                Clear EMPRESA
                Move (Value(Self)) to EMPRESA.CNPJ_EMPRESA
                Find eq EMPRESA by 2
                If (Found) Begin
                    Send pTelaFromBuffer
                End
            End
            
        End_Procedure
    End_Object

    Object oFrmNome is a Form
        Set Location to 5 159
        Set Size to 13 251
    End_Object

    Object oFrmResponsavel is a Form
        Set Label to "Responsável:"
        Set Location to 21 70
        Set Size to 13 250
    End_Object

    Object oFrmId is a Form
        Set Label to "Id:"
        Set Location to 21 350
        Set Size to 13 60
        Set Entry_State to False
        Set Enabled_State to False
        Set Label_Col_Offset to 25
        Set Form_Justification_Mode to Form_DisplayRight
    End_Object

    Object oFrmMunicipio is a Form
        Set Label to "Município (SC):"
        Set Location to 37 70
        Set Size to 13 250
    End_Object

    Object oFrmStatus is a ComboForm
        Set Label to "Status:"
        Set Location to 37 350
        Set Size to 13 60
        Set Label_Col_Offset to 25
        Set Combo_Sort_State to False
        Set Entry_State to False

        Procedure Combo_Fill_List
            Send Combo_Add_Item "Ativo"
            Send Combo_Add_Item "Inativo"
        End_Procedure
        
    End_Object

    Object oFrmSegmento is a ComboForm
        Set Label to "Segmento:"
        Set Location to 53 70
        Set Size to 13 250
        Set Combo_Sort_State to False
        Set Entry_State to False
        
        Procedure Combo_Fill_List
            Send Combo_Add_Item ""
            Send Combo_Add_Item "Tecnologia"
            Send Combo_Add_Item "Comércio"
            Send Combo_Add_Item "Indústria"
            Send Combo_Add_Item "Serviços"
            Send Combo_Add_Item "Agronegócio"
        End_Procedure
    End_Object
    
    Procedure pTelaFromBuffer
        Set Value of oFrmId          to (String(EMPRESA.ID_EMPRESA))
        Set Value of oFrmCNPJ        to (Trim(EMPRESA.CNPJ_EMPRESA))
        Set Value of oFrmNome        to (Trim(EMPRESA.NOME_EMPRESA))
        Set Value of oFrmResponsavel to (Trim(EMPRESA.NOME_RESPONSAVEL))
        Set Value of oFrmMunicipio   to (Trim(EMPRESA.MUNICIPIO_SC))
        Set Value of oFrmSegmento    to (GetDescricaoVT(Empresa_Segmento_VT, (Trim(EMPRESA.SEGMENTO))))
        Set Value of oFrmStatus      to (GetDescricaoVT(Empresa_Status_VT, EMPRESA.STATUS))
    End_Procedure

    Procedure pCarregarEmpresa Integer iId
        Clear EMPRESA
        Move iId to EMPRESA.ID_EMPRESA
        Find EQ EMPRESA by 1
        If (Found) Begin
            Send pTelaFromBuffer
        End
        Else Begin
            Send Info_Box "Empresa não encontrada." "Aviso"
        End
    End_Procedure

    Procedure pLimparTela        
        Set Value of oFrmId          to ""
        Set Value of oFrmNome        to ""
        Set Value of oFrmCNPJ        to ""
        Set Value of oFrmResponsavel to ""
        Set Value of oFrmMunicipio   to ""
        Set Value of oFrmSegmento    to ""
        Set Value of oFrmStatus      to "1"
        Clear EMPRESA
    End_Procedure

    Procedure pSalvar
        Integer iNovoID
        String sCNPJ sNome

        Get Value of oFrmNome to sNome
        Get Value of oFrmCNPJ to sCNPJ
        
        If (Trim(sNome) = "") Begin
            Send Info_Box "Informe o nome da empresa." "Validação"
            Procedure_Return
        End
        If (Trim(sCNPJ) = "") Begin
            Send Info_Box "Informe o CNPJ da empresa." "Validação"
            Procedure_Return
        End

        If (sCNPJ <> "") Begin
            Clear EMPRESA
            Move sCNPJ to EMPRESA.CNPJ_EMPRESA
            Find EQ EMPRESA by 2
            If (not(Found)) Begin
                Get fProximoIdEmpresa to iNovoID
                Clear EMPRESA
                Lock
                    Move iNovoID                                                        to EMPRESA.ID_EMPRESA
                    Move (Trim(Value(oFrmCNPJ)))                                        to EMPRESA.CNPJ_EMPRESA
                    Move (Trim(Value(oFrmNome)))                                        to EMPRESA.NOME_EMPRESA
                    Move (Trim(Value(oFrmResponsavel)))                                 to EMPRESA.NOME_RESPONSAVEL
                    Move (Trim(Value(oFrmMunicipio)))                                   to EMPRESA.MUNICIPIO_SC
                    Move (GetValorVT(Empresa_Segmento_VT, (Trim(Value(oFrmSegmento))))) to EMPRESA.SEGMENTO                    
                    Move (GetValorVT(Empresa_Status_VT, Value(oFrmStatus)))             to EMPRESA.STATUS
                    SaveRecord EMPRESA
                Unlock
            End
            Else Begin
                Reread EMPRESA
                    Move (Trim(Value(oFrmCNPJ)))                                        to EMPRESA.CNPJ_EMPRESA
                    Move (Trim(Value(oFrmNome)))                                        to EMPRESA.NOME_EMPRESA
                    Move (Trim(Value(oFrmResponsavel)))                                 to EMPRESA.NOME_RESPONSAVEL
                    Move (Trim(Value(oFrmMunicipio)))                                   to EMPRESA.MUNICIPIO_SC
                    Move (GetValorVT(Empresa_Segmento_VT, (Trim(Value(oFrmSegmento))))) to EMPRESA.SEGMENTO
                    Move (GetValorVT(Empresa_Status_VT, Value(oFrmStatus)))             to EMPRESA.STATUS
                    SaveRecord EMPRESA
                Unlock
            End
            Send Info_Box "Registro salvo." "OK"
        End
        
        Send pTelaFromBuffer
    End_Procedure

    Procedure pExcluir
        Integer iId
        Get Value of oFrmId to iId

        If (iId = 0) Begin
            Send Info_Box "Carregue uma empresa para excluir." "Validação"
            Procedure_Return
        End

        Clear EMPRESA
        Move iId to EMPRESA.ID_EMPRESA
        Find EQ EMPRESA by 1
        If (Found) Begin
            If (YesNo_Box("Confirma exclusão?", "Atenção", MB_DEFBUTTON2) = MBR_Yes) Begin
                Lock
                    Delete EMPRESA
                Unlock
                Send pLimparTela
            End
        End
    End_Procedure

    Object oBtnSalvar is a Button
        Set Label to "&Salvar"
        Set Location to 173 5
        Set Size to 18 70
        
        Procedure OnClick
            If (YesNo_Box("Deseja salvar?", "Atenção", MB_DEFBUTTON2) = MBR_Yes) Begin
                Send pSalvar
            End
        End_Procedure
    End_Object
    
    Object oBtnLimpar is a Button
        Set Label to "&Limpar"
        Set Location to 173 75
        Set Size to 18 70
        
        Procedure OnClick
            If (YesNo_Box("Deseja limpar a tela?", "Atenção", MB_DEFBUTTON2) = MBR_Yes) Begin
                Send pLimparTela
            End
        End_Procedure
    End_Object

    Object oBtnExcluir is a Button
        Set Label to "E&xcluir"
        Set Location to 173 145
        Set Size to 18 70
        
        Procedure OnClick
            Send pExcluir
        End_Procedure
    End_Object
    
    Object oBtnFechar is a Button
        Set Label to "&Fechar"
        Set Location to 173 215
        Set Size to 18 70
        
        Procedure OnClick
            Send pLimparTela
            Send Close_Panel
        End_Procedure
    End_Object

Cd_End_Object