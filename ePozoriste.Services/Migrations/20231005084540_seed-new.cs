using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class seednew : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "PredstavaVrstaPredstave",
                keyColumn: "PredstavaVPId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PredstavaVrstaPredstave",
                keyColumn: "PredstavaVPId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PredstavaVrstaPredstave",
                keyColumn: "PredstavaVPId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "PredstavaVrstaPredstave",
                keyColumn: "PredstavaVPId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "PredstavaVrstaPredstave",
                keyColumn: "PredstavaVPId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "PredstavaVrstaPredstave",
                keyColumn: "PredstavaVPId",
                keyValue: 6);

            migrationBuilder.AddColumn<int>(
                name: "VrstaPredstaveId",
                table: "Predstava",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(6279));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(6291));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(6295));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(6297));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(5189));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(5229));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 10, 45, 38, 685, DateTimeKind.Local).AddTicks(5232));

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 1,
                column: "VrstaPredstaveId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 2,
                column: "VrstaPredstaveId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 3,
                column: "VrstaPredstaveId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 4,
                column: "VrstaPredstaveId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 5,
                column: "VrstaPredstaveId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 6,
                column: "VrstaPredstaveId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 5, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 7, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 6, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 7, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 5, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 6, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.CreateIndex(
                name: "IX_Predstava_VrstaPredstaveId",
                table: "Predstava",
                column: "VrstaPredstaveId");

            migrationBuilder.AddForeignKey(
                name: "FK_Predstava_VrstaPredstave_VrstaPredstaveId",
                table: "Predstava",
                column: "VrstaPredstaveId",
                principalTable: "VrstaPredstave",
                principalColumn: "VrstaPredstaveId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Predstava_VrstaPredstave_VrstaPredstaveId",
                table: "Predstava");

            migrationBuilder.DropIndex(
                name: "IX_Predstava_VrstaPredstaveId",
                table: "Predstava");

            migrationBuilder.DropColumn(
                name: "VrstaPredstaveId",
                table: "Predstava");

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(5162));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(5172));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(5175));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(5177));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(3850));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(3893));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 1, 19, 11, 46, 271, DateTimeKind.Local).AddTicks(3896));

            migrationBuilder.InsertData(
                table: "PredstavaVrstaPredstave",
                columns: new[] { "PredstavaVPId", "PredstavaId", "VrstaPredstaveId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 },
                    { 3, 3, 1 },
                    { 4, 4, 1 },
                    { 5, 5, 2 },
                    { 6, 6, 2 }
                });

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 1, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 3, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 2, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 3, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 1, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 2, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
