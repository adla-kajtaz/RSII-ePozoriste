using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class updatedkupovinatable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "Kolicina",
                table: "Kupovina",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "Cijena",
                table: "Kupovina",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PaymentIntentId",
                table: "Kupovina",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 9, 24, 13, 50, 41, 66, DateTimeKind.Local).AddTicks(8608));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 9, 24, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PaymentIntentId",
                table: "Kupovina");

            migrationBuilder.AlterColumn<int>(
                name: "Kolicina",
                table: "Kupovina",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "Cijena",
                table: "Kupovina",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

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
        }
    }
}
