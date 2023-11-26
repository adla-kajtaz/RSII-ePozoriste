using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ePozoriste.Services.Migrations
{
    public partial class deletedtable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PredstavaVrstaPredstave");

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PredstavaVrstaPredstave",
                columns: table => new
                {
                    PredstavaVPId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PredstavaId = table.Column<int>(type: "int", nullable: true),
                    VrstaPredstaveId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Predstav__D51F265A1B68304F", x => x.PredstavaVPId);
                    table.ForeignKey(
                        name: "FK__Predstava__Preds__4AB81AF0",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                    table.ForeignKey(
                        name: "FK__Predstava__Vrsta__49C3F6B7",
                        column: x => x.VrstaPredstaveId,
                        principalTable: "VrstaPredstave",
                        principalColumn: "VrstaPredstaveId");
                });

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

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaVrstaPredstave_PredstavaId",
                table: "PredstavaVrstaPredstave",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaVrstaPredstave_VrstaPredstaveId",
                table: "PredstavaVrstaPredstave",
                column: "VrstaPredstaveId");
        }
    }
}
