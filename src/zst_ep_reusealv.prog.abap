*&---------------------------------------------------------------------*
*& Report ZST_EP_REUSEALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zst_ep_reusealv.
TABLES: sbook.

DATA: lt_fcat TYPE slis_t_fieldcat_alv,
      ls_fcat TYPE slis_fieldcat_alv.
DATA: it_spfli TYPE TABLE OF spfli.

START-OF-SELECTION.

  SELECT * FROM spfli INTO TABLE it_spfli.

  ls_fcat-fieldname = 'CONNID'.
  ls_fcat-edit = abap_true.
  ls_fcat-ref_tabname = 'SBOOK'.
  ls_fcat-ref_fieldname = 'CUSTOMID'.
  APPEND ls_fcat TO lt_fcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_title     = 'ALV Popup Demo'
      i_structure_name = 'SPFLI'
      it_fieldcat      = lt_fcat                 " Field catalog with field descriptions
*     i_screen_start_column = 10
*     i_screen_start_line   = 20
*     i_screen_end_column   = 100
*     i_screen_end_line     = 40
    TABLES
      t_outtab         = it_spfli.

FORM confirmation_prompt USING r_subrc.

  DATA: l_answer(1) TYPE c.
  DATA: l_title(30) TYPE c.
  CLEAR r_subrc.

  l_title(30) = TEXT-ti3.

  CALL FUNCTION 'POPUP_TO_CONFIRM_STEP'
    EXPORTING
      defaultoption = 'Y'
      textline1     = TEXT-020
      titel         = l_title
    IMPORTING
      answer        = l_answer
    EXCEPTIONS
      OTHERS        = 0.                                    "#EC *
  IF sy-subrc NE 0.
  ENDIF.
  CASE l_answer.
    WHEN 'N'.
      r_subrc = 4.
    WHEN 'A'.
      r_subrc = 8.
  ENDCASE.

ENDFORM.
