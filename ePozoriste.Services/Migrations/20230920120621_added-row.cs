using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class addedrow : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "TerminId",
                table: "Kupovina",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 9, 20, 14, 6, 20, 687, DateTimeKind.Local).AddTicks(4607));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 9, 20, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.CreateIndex(
                name: "IX_Kupovina_TerminId",
                table: "Kupovina",
                column: "TerminId");

            migrationBuilder.AddForeignKey(
                name: "FK_Kupovina_Termin_TerminId",
                table: "Kupovina",
                column: "TerminId",
                principalTable: "Termin",
                principalColumn: "TerminId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Kupovina_Termin_TerminId",
                table: "Kupovina");

            migrationBuilder.DropIndex(
                name: "IX_Kupovina_TerminId",
                table: "Kupovina");

            migrationBuilder.DropColumn(
                name: "TerminId",
                table: "Kupovina");

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 9, 17, 13, 52, 55, 248, DateTimeKind.Local).AddTicks(5780));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 9, 17, 0, 0, 0, 0, DateTimeKind.Local));
        }
    }
}
