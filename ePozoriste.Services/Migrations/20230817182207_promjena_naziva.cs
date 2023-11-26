using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class promjena_naziva : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "VrijemeOdrazvanja",
                table: "Termin",
                newName: "VrijemeOdrzavanja");

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 17, 20, 22, 6, 785, DateTimeKind.Local).AddTicks(6404));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 8, 17, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "VrijemeOdrzavanja",
                table: "Termin",
                newName: "VrijemeOdrazvanja");

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 15, 18, 41, 32, 483, DateTimeKind.Local).AddTicks(9327));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 8, 15, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
