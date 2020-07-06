  function init()
    m.top.setFocus(true)
    m.consulta=m.top.findNode("Consulta")
    m.consulta.content="Presiona hacia abajo para mas opciones"
    m.options= m.top.findNode("Options")
    m.VideoOptions=m.top.findNode("VideoOptions")
    m.VideoOptions.visible="false"
    m.consulta.visible="false"
    m.options.visible="false"
    m.videoPlayer=m.top.findNode("VideoPlayer")
    m.videoPlayer.videoControl="play"
    m.counter=1
    m.options.observeField("salida", "salidaOpciones")
    m.VideoOptions.observeField("salida", "salidaOpciones")
    m.VideoOptions.titulo=m.options.nodoContenido.title
  end function

  sub salidaOpciones()
  if m.options.salida=true or m.VideoOptions.salida=true then
  m.videoPlayer.setFocus(true)
  m.consulta.visible="false"
  m.options.visible="false"
  m.VideoOptions.visible="false"  
  m.videoPlayer.videoControl="resume"
  end if 
  end sub

  function onKeyEvent(key as String, press as Boolean) as Boolean
  ?"[OnEvent] mainScene"
  handled = false
  if press then
    if (key = "OK") then
    m.counter++
      ?"status video:stop and label visible"
      m.videoPlayer.thumbnailVisible="false"
      m.videoPlayer.controlVisible="true"
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
      if m.VideoOptions.isinfocuschain() then
      m.VideoOptions.visible="false"
      m.videoPlayer.videoControl="resume"
      m.VideoOptions.setFocus(false)
      m.top.setFocus(true)
      else
      m.consulta.visible="false"
      m.options.visible="true"
      m.VideoOptions.visible="false"
      m.videoPlayer.videoControl="pause"
      m.options.setFocus(true)
      m.options.hasFocus=true
      m.videoPlayer.controlVisible="false"
      handled = true
      end if
    else if (key="left") then 
      ?"izquierda"
      m.videoPlayer.thumbnailVisible="true"
      m.videoPlayer.videoControl="pause"
      m.videoPlayer.skip10Seconds="false"
      m.consulta.visible="true"
    else if (key="right") then 
      ?"derecha"
      m.videoPlayer.thumbnailVisible="true"
      m.videoPlayer.videoControl="pause"
      m.videoPlayer.skip10Seconds="true"
      m.consulta.visible="true"
    else if (key="replay") then 
      ?"Opcioneses"
       m.VideoOptions.hasFocus=true
      m.videoPlayer.videoControl="pause"
      m.VideoOptions.setFocus(true)
      m.VideoOptions.visible="true"
      m.videoPlayer.controlVisible="false"
    end if
  end if
  return handled
end function


