using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class terminUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "DatumOdrzavanja",
                table: "Termin",
                type: "datetime",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(7020));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(7030));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(7033));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(7035));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(6234));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(6273));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 16, 14, 16, 2, 96, DateTimeKind.Local).AddTicks(6276));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 16, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 18, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 17, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 18, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 16, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 17, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "DatumOdrzavanja",
                table: "Termin",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime");

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 15, DateTimeKind.Local).AddTicks(1));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 15, DateTimeKind.Local).AddTicks(11));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 15, DateTimeKind.Local).AddTicks(13));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 15, DateTimeKind.Local).AddTicks(15));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 14, DateTimeKind.Local).AddTicks(9183));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 14, DateTimeKind.Local).AddTicks(9229));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 11, 38, 59, 14, DateTimeKind.Local).AddTicks(9232));

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
        }
    }
}
