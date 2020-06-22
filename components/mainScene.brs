  function init()
    m.top.setFocus(true)
    m.consulta=m.top.findNode("Consulta")
    m.consulta.content="Presiona hacia abajo para mas opciones"
    m.options= m.top.findNode("Options")
    m.consulta.visible="false"
    m.options.visible="false"
    m.videoPlayer=m.top.findNode("VideoPlayer")
    m.videoPlayer.videoControl="play"
    m.counter=1
    m.options.observeField("salida", "salidaOpciones")
  end function

  sub salidaOpciones()
  if m.options.salida=true then
  m.videoPlayer.setFocus(true)
  m.consulta.visible="false"
  m.options.visible="false"
  m.videoPlayer.videoControl="resume"
  end if 
  end sub

  function onKeyEvent(key as String, press as Boolean) as Boolean
  ?"[OnEvent] mainScene"
  handled = false
  if press then
    if (key = "OK") then
    m.counter++
    ' print counter
      ?"HOLA"
      ?"status video:stop and label visible"
      if m.counter mod 2 = 0 then
      m.videoPlayer.videoControl="pause"
      m.consulta.visible="true"
      ?"Pauso"
      else 
      m.videoPlayer.videoControl="resume"
      m.consulta.visible="false"
      ?"Continuo"
      end if
    else if (key = "down") then
      ?"ABAJO"
      ?"label no visible, aparece options y se le asigna el focus"
      m.consulta.visible="false"
      m.options.visible="true"
      m.videoPlayer.videoControl="pause"
      m.options.setFocus(true)
      m.options.hasFocus=true
      handled = true
    else if (key="left") then 
      ?"izquierda"
      m.videoPlayer.videoControl="pause"
      m.videoPlayer.skip10Seconds="false"
      m.consulta.visible="true"
    else if (key="right") then 
      ?"derecha"
      m.videoPlayer.videoControl="pause"
      m.videoPlayer.skip10Seconds="true"
      m.consulta.visible="true"
    end if
  end if
  return handled
end function


