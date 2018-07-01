---------------------------------
-- Vuelos.lua
-- Hernán Cano Martínez
-- Ene-2018
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

cmbC = iup.list   { value=1 , expand='NO', floating='NO', rastersize ="150", cx="030", cy="000", font ="Courier New, 10", NC='10', ACTIVE='YES', ALIGNMENT='ACENTER', " sólo de ida   ", " ida y regreso ", dropdown="Yes" --[[, valuechanged_cb = cmbC_valuechanged_cb]] }

txt1 = iup.text   { value="", expand='NO', floating='NO', rastersize ="150", cx="030", cy="050", font ="Courier New, 10", NC='10', ACTIVE='YES', ALIGNMENT='ACENTER' }
txt2 = iup.text   { value="", expand='NO', floating='NO', rastersize ="150", cx="030", cy="100", font ="Courier New, 10", NC='10', ACTIVE='No' , ALIGNMENT='ACENTER' }

txt1.Value = os.date("%Y.%m.%d")
txt2.Value = os.date("%Y.%m.%d")

btnB = iup.button { title = "Reservar", expand='NO', floating='NO', rastersize ="155x35", cx="030", cy="150", font ="Segoe IU, 9", TIP='Haga click para reservar' }

-- ***************************************************************************

 function ValidDates()
   if (tonumber(cmbC.Value) == 2) then -- ida y regreso 
      if (txt2.Value >= txt1.Value) then
         -- MessageBox( 'es mayor txt2' )
         btnB.ACTIVE = 'YES'
      else
         btnB.ACTIVE = 'NO'
         -- MessageBox( 'es mayor txt1' )
      end
   end
         -- MessageBox(btnB.ACTIVE )
 end
 
---- ***************************************************************************

-- el Contenedor de controles

vArea = iup.cbox{ expand='NO', floating='NO', size = "250x300",
  cmbC, txt1, txt2, btnB,
  nil
}

-- El formulario

frmVuelos = iup.dialog{ expand='NO', floating='NO', 
  vArea,
  title = "Reserva de Vuelos", 
  size = "150x150"
}

-- ********************************** Callbacks *****************************************

function btnB:action()
  
  -- MessageBox ( cmbC.Value ) 
 	  -- iup.Message('Usted ha reservado un vuelo de ida para la fecha '..txt1.Value,'hcano')
   if tonumber(cmbC.Value) == 1 then -- sólo de ida 
 	  MessageBox('Usted ha reservado un vuelo de ida para la fecha '..txt1.Value)
   end
   if tonumber(cmbC.Value) == 2 then -- ida y regreso 
 	  MessageBox('Usted ha reservado un vuelo de ida y vuelta, donde la ida es en '..txt1.Value..' y la vuelta para '..txt2.Value)
   end
  -- MessageBox ( 'txt2.active '..txt2.active ) 
  
  -- Exits the main loop
  -- return iup.CLOSE  
  -- return iup.DEFAULT
end


function txtC_action(t, new_value)

   if new_value and tonumber(new_value) then
      local nNum = tonumber(new_value)
      txtF.value = nNum * (9/5) + 32
   end
   
end

function cmbC.valuechanged_cb(self)
  local value = self.value
  -- MessageBox ( value )
   if tonumber(value) == 1 then -- sólo de ida 
	  txt2.active='NO'
   end
   if tonumber(value) == 2 then -- ida y regreso 
	  txt2.active='YES'
   end
  -- iup.SetAttribute(iup.GetDialog(self), "TOOLSTYLE", value)
end

function txt1:killfocus_cb() --(t, new_value)
      ValidDates()
end

function txt2:killfocus_cb() --(t, new_value)
      ValidDates()
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
