﻿using CsvHelper;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace notaFiscalCsvHelper
{
    public class LectorCSV
    {
        public IEnumerable<ExcelPackage> ConvierteCsvAExcel(string carpetaOrigen, IEnumerable<string> lNombreArchivos)
        {
            List<ExcelPackage> archivosXl = new List<ExcelPackage>();
            foreach (string archivoCsv in lNombreArchivos)
            {

                using (var reader = new StreamReader(Path.Combine(carpetaOrigen, archivoCsv), Encoding.GetEncoding("windows-1254")))
                using (var csv = new CsvReader(reader))
                {
                    csv.Configuration.HasHeaderRecord = false;
                    var records = csv.GetRecords<SerieB_RF>();
                    //ExcelPackage xlp = new ExcelPackage();
                    //xlp = ;
                    archivosXl.Add(CreaExcel(records, archivoCsv));
                }
            }
            return archivosXl;
        }

        private ExcelPackage CreaExcel(IEnumerable<SerieB_RF> records, string nombreArchivoCsv)
        {
            //using (var package = new ExcelPackage())
            //{
            var package = new ExcelPackage();
            Decimal unitprice = 0;
            ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("NF");
            int i = 1;
            System.Globalization.CultureInfo culInfo = new System.Globalization.CultureInfo("de-DE"); 
            foreach (SerieB_RF record in records)
                {
                    worksheet.Cells[i, 1].Value = record.Prefixo;
                    worksheet.Cells[i, 2].Value = record.InvNo;
                    worksheet.Cells[i, 3].Value = record.InvDate;
                    worksheet.Cells[i, 4].Value = record.FixedT;

//                    worksheet.Cells[i, 5].Style.Numberformat.Format = "###.###.##0,00";
                    unitprice = Convert.ToDecimal(record.Amount, culInfo);
//                if (Decimal.TryParse(record.Amount, System.Globalization.NumberStyles.Number, culInfo.NumberFormat, out unitprice))
                    worksheet.Cells[i, 5].Value = unitprice;
//                    else
//                        throw new FormatException("El monto es incorrecto en la fila " + i.ToString() + ", columna 5 " + " [CreaExcel]");

                    worksheet.Cells[i, 6].Value = record.CodigoServicio1;
                    worksheet.Cells[i, 7].Value = record.CodigoServicio2;
                    worksheet.Cells[i, 8].Value = record.AliquotaIss;
                    worksheet.Cells[i, 9].Value = record.cnpj_cp;
                    worksheet.Cells[i, 10].Value = record.Desconocido1;
                    worksheet.Cells[i, 11].Value = record.RazaoSocial;
                    worksheet.Cells[i, 12].Value = record.TipoLogradouro;
                    worksheet.Cells[i, 13].Value = record.Logradouro;
                    worksheet.Cells[i, 14].Value = record.Numero;
                    worksheet.Cells[i, 15].Value = record.AdditionalInfo;
                    worksheet.Cells[i, 16].Value = record.Bairro;
                    worksheet.Cells[i, 17].Value = record.Cidade;
                    worksheet.Cells[i, 18].Value = record.Estado;
                    worksheet.Cells[i, 19].Value = record.Cep;
                    worksheet.Cells[i, 20].Value = record.email;
                    worksheet.Cells[i, 21].Value = record.Descricao;
                    worksheet.Cells[i, 22].Value = record.DataVencimento;
                    worksheet.Cells[i, 23].Value = record.ImageNumber;
                    worksheet.Cells[i, 24].Value = record.DescricaoColecao;

                    unitprice = Convert.ToDecimal(record.ValorUnitario, culInfo);
                    worksheet.Cells[i, 25].Value = unitprice;
                    worksheet.Cells[i, 26].Value = record.Desconocido2;
                    i++;
                }
                package.Workbook.Properties.Title = nombreArchivoCsv;
                return package;
            //}
        }
    }
}