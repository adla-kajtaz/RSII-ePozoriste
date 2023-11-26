using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class changedrelationshipkartakupovina : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Kupovina__KartaI__5165187F",
                table: "Kupovina");

            migrationBuilder.DropIndex(
                name: "IX_Kupovina_KartaId",
                table: "Kupovina");

            migrationBuilder.DropColumn(
                name: "KartaId",
                table: "Kupovina");

            migrationBuilder.AddColumn<int>(
                name: "KupovinaId",
                table: "Karta",
                type: "int",
                nullable: true);

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

            migrationBuilder.CreateIndex(
                name: "IX_Karta_KupovinaId",
                table: "Karta",
                column: "KupovinaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Karta_Kupovina_KupovinaId",
                table: "Karta",
                column: "KupovinaId",
                principalTable: "Kupovina",
                principalColumn: "KupovinaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Karta_Kupovina_KupovinaId",
                table: "Karta");

            migrationBuilder.DropIndex(
                name: "IX_Karta_KupovinaId",
                table: "Karta");

            migrationBuilder.DropColumn(
                name: "KupovinaId",
                table: "Karta");

            migrationBuilder.AddColumn<int>(
                name: "KartaId",
                table: "Kupovina",
                type: "int",
                nullable: true);

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

            migrationBuilder.CreateIndex(
                name: "IX_Kupovina_KartaId",
                table: "Kupovina",
                column: "KartaId");

            migrationBuilder.AddForeignKey(
                name: "FK__Kupovina__KartaI__5165187F",
                table: "Kupovina",
                column: "KartaId",
                principalTable: "Karta",
                principalColumn: "KartaId");
        }
    }
}
