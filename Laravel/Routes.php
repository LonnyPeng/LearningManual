<?php

/* Route Files*/


/*
 * init
 */
Route::get('/', function () {
	return view('welcome');
});

/*
 * 01
 */
Route::get('/', function () {
	return 'Hello World';
});

/* 
 * 02
 *
class NameController extends Controller
{
	public function index()
	{
		//
	}
}
 *
 */
Route::get('/', 'NameController@index');

/* 
 * 03
 *
class NameController extends Controller
{
	public function getIndex()
	{
		//
	}

	public function getAbout()
	{
		//
	}
}
 *
 */
Route::controller('/', 'NameController');

/* 
 * 03
 *
class NameController extends Controller
{
	public function getIndex($id)
	{
		//
	}
}
 *
 */
 Route::get('name/{id}', 'NameController@getIndex');