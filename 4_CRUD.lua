---------------------------------
-- 4_CRUD.lua
--   (Create, Read, Update and Delete)
-- Hernán Cano Martínez
-- Jul-2018
---------------------------------

package.cpath = "?.dll;?53.dll;lua533/?.dll;lua533/?53.dll;"   -- [in Windows]

require ( "iuplua" )

-- ***************************************************************************
function MessageBox ( pTit, pCad )
   if (pCad) then
   return iup.Message( pTit or '', pCad or '' )
   else
   return iup.Message( pCad or '', pTit or '' )
   end
end

-- ***************************************************************************

-- los controles que usaremos en nuestro formulario

lblC = iup.label  { title = "Buscar:"  , expand='NO', floating='NO', rastersize = "70x25", cx="030", cy="010", font ="Courier New, 10" }  -- size  in pixels

cmbC = iup.list   { value="0", expand='NO', floating='NO', rastersize ="200x150", cx="030", cy="050", font ="Courier New, 10", ACTIVE='YES', dropdown="No", editbox="No", multiple="No" } -- , ALIGNMENT='ACENTER'

lblN = iup.label  { title = "Nombre  :", expand='NO', floating='NO', rastersize = "80x25", cx="270", cy="050", font ="Courier New, 10" }  -- size  in pixels
lblA = iup.label  { title = "Apellido:", expand='NO', floating='NO', rastersize = "80x25", cx="270", cy="100", font ="Courier New, 10" }  -- size  in pixels

                                                                                                                                                 
txt0 = iup.text   { value="", expand='NO', floating='NO', rastersize ="130", cx="100", cy="010", font ="Courier New, 10", NC='20', ACTIVE='YES', FILTER='UPPERCASE' } -- , ALIGNMENT='ACENTER'
txtN = iup.text   { value="", expand='NO', floating='NO', rastersize ="120", cx="350", cy="053", font ="Courier New, 10", NC='20', ACTIVE='YES', FILTER='UPPERCASE' } -- , ALIGNMENT='ACENTER'
txtA = iup.text   { value="", expand='NO', floating='NO', rastersize ="120", cx="350", cy="103", font ="Courier New, 10", NC='20', ACTIVE='YES', FILTER='UPPERCASE' } -- , ALIGNMENT='ACENTER'

btnC = iup.button { title = "Nuevo"     , expand='NO', floating='NO', rastersize ="100x35", cx="030", cy="230", font ="Segoe IU, 9", TIP='Haga click para agregar un nuevo registro'   , flat='No' }
btnU = iup.button { title = "Actualizar", expand='NO', floating='NO', rastersize ="100x35", cx="150", cy="230", font ="Segoe IU, 9", TIP='Haga click para modificar el actual registro', flat='No' }
btnD = iup.button { title = "Borrar"    , expand='NO', floating='NO', rastersize ="100x35", cx="270", cy="230", font ="Segoe IU, 9", TIP='Haga click para retirar el actual registro'  , flat='No' }

-- ***************************************************************************

-- el Contenedor de controles

vArea = iup.cbox{ expand='NO', floating='NO', size = "250x300",
  cmbC, lblC, lblN, lblA, txt0, txtN, txtA, btnC, btnU, btnD,
  nil
}

-- El formulario

frmVuelos = iup.dialog{ expand='NO', floating='NO', 
  vArea,
  title = "Formulario CRUD", 
  size = "350x200"
}

-- ********************************** Callbacks *****************************************

function cmbC.DBLCLICK_CB()  -- BUTTON_CB  -- no one of both runs....
      MessageBox( cmbC.Value )
      if cmbC.Value then
         local nCnt 
         nCnt = cmbC.Value
		 txtN.Value = cmbC[nCnt]
         txtA.Value = cmbC[nCnt]
      end
end

function btnC:action()
      if (txtA.Value and txtN.Value) then
         cmbC[cmbC.COUNT+1] = txtN.Value..', '..txtA.Value
      end
end


function btnU:action()
   if (txtA.Value and txtN.Value and cmbC.Value) then
      local nCnt 
      nCnt = cmbC.Value
      cmbC[nCnt] = txtN.Value..', '..txtA.Value
   end
end

 
function btnD:action()
   if (txtA.Value and txtN.Value and cmbC.Value) then
      local nCnt 
      nCnt = cmbC.Value
	  iup.SetAttribute  (cmbC, 'REMOVEITEM', nCnt)
   end
end

 
function txtC_action(t, new_value)
   if new_value and tonumber(new_value) then
      local nNum = tonumber(new_value)
      txtF.value = nNum * (9/5) + 32
   end
   
end

--------------------------------------------

-- Ahora sí: mostremos el formulario

frmVuelos:showxy(iup.CENTER,iup.CENTER)

-- to be able to run this script inside another context
-- if (iup.MainLoopLevel()==0) then
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end

----------------------------------------------
