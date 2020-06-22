sub init()
  m.top.setFocus(true)
  setVideo()
end sub
function setVideo() as void
  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.streamFormat = "mp4"
  videoContent.url="http://video.ted.com/talks/podcast/DanGilbert_2004_480.mp4"
  m.video = m.top.findNode("VideoPlayer")
  m.video.content = videoContent
  m.PlayBar = m.top.findNode("PlayBar")
  m.TimeBarBack= m.top.findNode("TimeBarBack")
  m.TimeBarFront= m.top.findNode("TimeBarFront")
  m.Poster=m.top.findNode("Poster")
  m.AudioCurrent=m.top.findNode("AudioCurrent")
  m.AudioDuration=m.top.findNode("AudioDuration")
  m.RectangleControls= m.top.findNode("RectangleControls")
  m.TimerAnim=m.top.findNode("TimerAnim")
  m.myInterp2=m.top.findNode("myInterp2")
  m.control=m.top.findNode("control")
  m.RewindAnim=m.top.findNode("RewindAnim")
  m.FFAnim=m.top.findNode("FFAnim")
  m.testPoster=m.top.findNode("testPoster")
  m.testPoster.uri="pkg:/images/unicorn/00000002.jpg"
  centerx=(m.PlayBar.width-m.TimeBarBack.width)/2
  m.TimeBarBack.translation = [centerx,100]
  m.AudioCurrent.translation=[centerx-m.AudioCurrent.width+10,100-m.AudioCurrent.height]
  m.AudioDuration.translation=[centerx+m.TimeBarBack.width+20,100-m.AudioDuration.height]
  medidaRectangleControls=m.RectangleControls.boundingRect()
  m.RectangleControls.translation=[(m.PlayBar.width-medidaRectangleControls.width)/2,20]
  m.AudioCurrent.text=secondsToHours(0)
  m.TimerAnim.control="stop"
  m.control.visible="false"
  m.TimeBarFront.observeField("translation","cambiaPosicionImagen")
end function
sub cambiaPosicionImagen()
traslacion=m.TimeBarFront.translation
m.testPoster.translation=[traslacion[0]+30,-75]
end sub
sub muestraControl()
if m.video.control="pause" then 
m.control.visible="true"
m.TimerAnim.control="pause"
else 
m.control.visible="false"
m.TimerAnim.control = "resume"
end if
end sub
sub asignaDuration()
  m.AudioDuration.text=secondsToHours(m.top.tiempoTotal)
  m.TimerAnim.duration=m.top.tiempoTotal
  m.TimerAnim.control="start"
end sub
sub recorreReloj()
m.AudioCurrent.text=secondsToHours(m.top.recorrido)
m.AudioDuration.text=secondsToHours(m.top.tiempoTotal-m.top.recorrido)
end sub 
Function secondsToHours(seconds as integer) as String 
    z= seconds\3600 'horas
    seconds = seconds mod 3600
    x = seconds\60 'minutos
    y = seconds MOD 60 'segundos
    if y < 10
        y = y.toStr()
        y = "0"+y
    else 
        y = y.toStr()
    end if
    if x < 10
        x = x.toStr()
        x = "0"+x
    else 
        x = x.toStr()
    end if
    result = z.toStr()
    result = result +":"+x+":"+y
    return result
end Function

sub skip10Seconds() 
'Si pico adelantar
    if m.top.skip10Seconds=true then
        if (m.top.tiempoTotal - 10) > m.top.recorrido
            print "Si puedo avanzar"
            posicionInicial=[m.video.position*(m.TimeBarBack.width/m.top.tiempoTotal),0]
            m.video.position=m.top.recorrido+10
            posicionFinal=[m.video.position*(m.TimeBarBack.width/m.top.tiempoTotal),0]
            m.FFAnim.control = "start"
            m.myInterp2.KeyValue = [posicionInicial, posicionFinal]
            m.TimerAnim.duration =1
            m.TimerAnim.control = "start"
            m.video.seek=m.video.position
            imagen= convierteImagen((m.video.position/10)\1)
            m.testPoster.uri="pkg:/images/unicorn/"+imagen+".jpg"
        else
            print "No puedo avanzar"
            m.video.position=m.top.tiempoTotal
            m.FFAnim.control = "start"
            m.TimerAnim.control = "stop"
            m.video.seek=m.video.position
        end if
'Si pico atrasar
    else
        if m.top.recorrido > 10
            print "Si puedo retroceder"
            posicionInicial=[m.video.position*(m.TimeBarBack.width/m.top.tiempoTotal),0]
            m.video.position=m.top.recorrido-10
            posicionFinal=[m.video.position*(m.TimeBarBack.width/m.top.tiempoTotal),0]
            m.RewindAnim.control = "start"
            m.myInterp2.KeyValue = [posicionInicial, posicionFinal]
            m.TimerAnim.duration =1
            m.TimerAnim.control = "start"
            m.video.seek=m.video.position
            imagen= convierteImagen((m.video.position/10)\1)
            m.testPoster.uri="pkg:/images/unicorn/"+imagen+".jpg"
        else
            print "No puedo retrocede por que ya se acabo el video"
            posicionInicial=[m.video.position*(m.TimeBarBack.width/m.top.tiempoTotal),0]
            m.video.position=0
            posicionFinal=[m.video.position*(m.TimeBarBack.width/m.top.tiempoTotal),0]
            m.RewindAnim.control = "start"
            m.myInterp2.KeyValue = [posicionInicial,posicionFinal]
            m.TimerAnim.duration = 1
            m.TimerAnim.control = "start"           
            m.video.seek=m.video.position
        end if
    end if
    m.myInterp2.KeyValue = [posicionFinal,[m.TimeBarBack.width,0]]
    m.TimerAnim.duration = m.top.tiempoTotal-m.top.recorrido
    m.TimerAnim.control = "start"
end sub

function convierteImagen(entero)
imagen=entero.toStr()
while (Len(imagen)<8)
    imagen="0"+imagen
end while
return imagen 
end function