<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReservasisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('reservasi', function (Blueprint $table) {
            $table->id();
            $table->integer('kode_reservasi');
            $table->string('nomor_antrian', 15);
            $table->foreignId('customer_id')->constrained('user');
            $table->foreignId('jenis_reservasi_id')->constrained('jenis_reservasi');
            $table->foreignId('layanan_id')->constrained('layanan');
            $table->time('jam_reservasi');
            $table->date('tanggal_reservasi');
            $table->string('no_plat', 15);
            $table->enum('status', ['Selesai','Belum Selesai']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reservasi');
    }
}
