sub init()
m.consulta=m.top.findNode("Consulta")
m.consulta.content="Presiona hacia abajo para salir"
m.consulta.heightConsulta="580"
botones=[
      {Title:"Grabar temporada"
      SDPosterUrl:"pkg:/images/cine.png"
      }
      {Title:"Grabar episodio"
      SDPosterUrl:"pkg:/images/cine.png"
      }
      {Title:"Ver desde inicio"
      SDPosterUrl:"pkg:/images/cine.png"
      }
      {Title:"Bloquear canal"
      SDPosterUrl:"pkg:/images/cine.png"
      }
      {Title:"Eliminar de favoritos"
      SDPosterUrl:"pkg:/images/cine.png"
      }
      {Title:"Cambiar subtitulos"
      SDPosterUrl:"pkg:/images/cine.png"
      }
      {Title:"Ir a guía completa "
      SDPosterUrl:"pkg:/images/cine.png"
      }
      ]
    listaBotones= [
        {
            Title: "Lista de botones de eleccion"
            ContentList: botones
        }
    ]
contentBotones = parseContent(listaBotones)
m.myRowListOptions=m.top.findNode("myRowListOptions")
m.myRowListOptions.elements=7
m.myRowListOptions.content=contentBotones
m.myRowListOptions.numFilas=1
m.myRowListOptions.mostrarLabel=true
m.myRowListOptions.nameComponent="RowListItemOptions"
m.myRowListOptions.itemSize=[[160,140]]

medidaRowListOptions=m.myRowListOptions.boundingRect()

m.myRowListOptions.heightComponent=medidaRowListOptions.height

end sub

function parseContent(list As Object)
    ContentNode_object = createObject("RoSGNode","ContentNode")
    for each objeto in list
        ContentNode_object_child = createObject("RoSGNode","ContentNode")
        ContentNode_object_child.Title=objeto.Title
        for each arreglo in objeto.ContentList
                elemento=createObject("RoSGNode","ContentNode")
                elemento.setFields(arreglo)
                ContentNode_object_child.appendChild(elemento)
        end for
        ContentNode_object.appendChild(ContentNode_object_child)
    end for
    return ContentNode_object
end function