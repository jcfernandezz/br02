﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MaquinaDeEstados
{
    public class Transicion
    {
        //public static string[] eventos = { "ensamblaLote", "anulaFolioEnSII", "enviaAlSII", "recibeDelSIIAceptado", "recibeDelSIIConReparos",
        //                                   "recibeDelSIIRechazado", "enviaAlCliente"};
        //ATENCION! agregar condición de guarda para cada evento

        private int _evento;
        private string _accion;
        private int _origen;
        private int _destino;
        private String _tipo;

        //public int iErr;
        public string sMsj;

        public Transicion()
        { }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="evto"></param>
        /// <param name="acc"></param>
        /// <param name="tipo">std: transición estándar
        ///                     sco: transición a subcomponente</param>
        /// <param name="org"></param>
        /// <param name="dest"></param>
        public Transicion(int evto, string acc, String tipo, int org, int dest)
        {
            _evento = evto;
            _accion = acc;
            _origen = org;
            _destino = dest;
            _tipo = tipo;
        }

        public String Tipo
        {
            get { return _tipo; }
            set { _tipo = value; }
        }

        public int evento
        {
            get { return _evento; }
            set { _evento = value; }
        }

        public string accion
        {
            get { return _accion; }
            set { _accion= value; }
        }
        public int origen
        {
            get { return _origen; }
            set { _origen = value; }
        }
        public int destino
        {
            get { return _destino; }
            set { _destino = value; }
        }

        public bool CondicionDeGuarda(int evento, int anulado, int conAcceso)
        {
            bool ok = false;

            if (anulado == 1)
                throw new ArgumentException("El documento está anulado en GP. [Transicion.CondicionDeGuarda]");
            else
            {
                if (evento == Maquina.eventoGeneraTxt)   //ensambla archivo txt
                {
                    if (conAcceso == 1)
                        ok = true;

                    if (conAcceso == 0)
                        throw new ArgumentException("No tiene permisos para generar el archivo txt. Verifique los permisos en la ventana de mantenimiento de Certificados de GP.");
                }

                if (evento == Maquina.eventoPrefecturaAcepta)
                {
                    ok = true;
                }

                if (evento == Maquina.eventoModificaFacturaEnLote)
                {
                    if (conAcceso == 1)
                        ok = true;

                    if (conAcceso == 0)
                        throw new ArgumentException("No tiene permisos para emitir una factura modificada. Verifique los permisos en la ventana de mantenimiento de Certificados de GP. [Transicion.CondicionDeGuarda]");
                }
                if (evento == Maquina.eventoAnulaNfse)
                {
                    if (conAcceso == 1)
                        ok = true;

                    if (conAcceso == 0)
                        throw new ArgumentException("No tiene permisos para anular documentos. Verifique los permisos en la ventana de mantenimiento de Certificados de GP. [Transicion.CondicionDeGuarda]");
                }
            }

            return ok;
        }
    }
}
