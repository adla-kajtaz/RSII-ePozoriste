using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class addnewline : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(4736));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(4750));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(4753));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(4756));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(3408));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(3454));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 5, 11, 24, 8, 270, DateTimeKind.Local).AddTicks(3458));
        }
    }
}
