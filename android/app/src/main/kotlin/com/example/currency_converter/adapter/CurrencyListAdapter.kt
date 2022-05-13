package com.example.currency_converter.adapter

import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.core.content.res.ResourcesCompat
import androidx.recyclerview.widget.RecyclerView
import com.example.currency_converter.R
import com.example.currency_converter.utils.Utility
import com.example.interfaces.CurrencySelectListener
import com.example.model.Country
import java.util.*

class CurrencyListAdapter(
    val context: Context,
    var currencyList: ArrayList<Country>,
    val type: Int,
    val listener: CurrencySelectListener,
) :
    RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        val layout: RelativeLayout = itemView.findViewById(R.id.layout_select_currency)
        val imgFlag: ImageView = itemView.findViewById(R.id.img_flag)
        val txtCode: TextView = itemView.findViewById(R.id.txt_code)
        val txtName: TextView = itemView.findViewById(R.id.txt_name)
        val imgBtn: ImageButton = itemView.findViewById(R.id.img_cancel)


    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.selected_list_item, parent, false)

        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = currencyList[position]

        holder.imgFlag.setImageDrawable(item.flag)
        holder.txtCode.text = item.code
        holder.txtName.text = item.name


        if (type == 1) {
            holder.imgBtn.setImageDrawable(ResourcesCompat.getDrawable(context.resources,R.drawable.ic_close,null))
        } else {
            holder.imgBtn.setImageDrawable(ResourcesCompat.getDrawable(context.resources,R.drawable.ic_add,null))

        }

        val colorCode = Utility.getWidgetColor( context)
        val color: Int = Color.parseColor("#$colorCode")
        holder.imgBtn.setColorFilter(color)

        holder.imgBtn.setOnClickListener(View.OnClickListener {
            removeItem(item, position)
        })


        if(Utility.isDarkTheme(context)){

            holder.layout.setBackgroundResource(R.drawable.dartk_round)
            holder.txtCode.setTextColor(context.resources.getColor(R.color.white))
            holder.txtName.setTextColor(context.resources.getColor(R.color.white))

        }else{
            holder.layout.setBackgroundResource(R.drawable.white_round)
            holder.txtCode.setTextColor(context.resources.getColor(R.color.black))
            holder.txtName.setTextColor(context.resources.getColor(R.color.black))
        }


    }

    private fun removeItem(item: Country, position: Int) {
        currencyList.removeAt(position)
        listener.onItemRemove(item, position)

        notifyDataSetChanged()
    }

    fun addItem(item: Country) {
        currencyList.add(item)

        if (type == 2) {
            currencyList.sortBy { it.code }.apply { }
        }
        listener.onItemAdd(currencyList)

        notifyDataSetChanged()
    }

    override fun getItemCount(): Int {
        return currencyList.size
    }
}