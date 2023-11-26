using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class fixedTypo : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 1, DateTimeKind.Local).AddTicks(1930));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 1, DateTimeKind.Local).AddTicks(1951));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 1, DateTimeKind.Local).AddTicks(1953));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 1, DateTimeKind.Local).AddTicks(1955));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 0, DateTimeKind.Local).AddTicks(9886));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 0, DateTimeKind.Local).AddTicks(9926));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 18, 18, 4, 41, 0, DateTimeKind.Local).AddTicks(9980));

            migrationBuilder.UpdateData(
                table: "ObavijestKategorija",
                keyColumn: "ObavijestKategorijaId",
                keyValue: 3,
                column: "Naziv",
                value: "Obavijest");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 18, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 20, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 21, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 20, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 18, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 21, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 783, DateTimeKind.Local).AddTicks(218));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 783, DateTimeKind.Local).AddTicks(232));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 783, DateTimeKind.Local).AddTicks(235));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 783, DateTimeKind.Local).AddTicks(239));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 782, DateTimeKind.Local).AddTicks(8512));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 782, DateTimeKind.Local).AddTicks(8570));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 17, 15, 36, 15, 782, DateTimeKind.Local).AddTicks(8574));

            migrationBuilder.UpdateData(
                table: "ObavijestKategorija",
                keyColumn: "ObavijestKategorijaId",
                keyValue: 3,
                column: "Naziv",
                value: "Obavijet");

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 17, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 19, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 18, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 19, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 17, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 18, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
