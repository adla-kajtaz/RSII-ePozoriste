using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class newFiledInKupovina : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Placena",
                table: "Kupovina",
                type: "bit",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                columns: new[] { "DatumKupovine", "Placena" },
                values: new object[] { new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(6134), true });

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                columns: new[] { "DatumKupovine", "Placena" },
                values: new object[] { new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(6148), true });

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                columns: new[] { "DatumKupovine", "Placena" },
                values: new object[] { new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(6152), true });

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                columns: new[] { "DatumKupovine", "Placena" },
                values: new object[] { new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(6155), true });

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(4647));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(4692));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 19, 10, 45, 55, 653, DateTimeKind.Local).AddTicks(4696));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 19, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 21, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 22, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 21, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 19, 0, 0, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6,
                column: "DatumOdrzavanja",
                value: new DateTime(2023, 10, 22, 0, 0, 0, 0, DateTimeKind.Local));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Placena",
                table: "Kupovina");

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 1,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(9538));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 2,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(9556));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 3,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(9559));

            migrationBuilder.UpdateData(
                table: "Kupovina",
                keyColumn: "KupovinaId",
                keyValue: 4,
                column: "DatumKupovine",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(9561));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(8291));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(8328));

            migrationBuilder.UpdateData(
                table: "Obavijest",
                keyColumn: "ObavijestId",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 10, 18, 18, 28, 56, 847, DateTimeKind.Local).AddTicks(8331));

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
    }
}
