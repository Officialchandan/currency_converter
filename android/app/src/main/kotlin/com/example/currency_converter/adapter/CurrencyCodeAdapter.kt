package com.example.currency_converter.adapter

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.recyclerview.widget.RecyclerView
import com.example.currency_converter.R
import com.example.interfaces.ItemClickListener
import com.example.model.Country
import java.util.*
import kotlin.collections.ArrayList

class CurrencyCodeAdapter(
    currencyList: List<Country>,
    type: Int,
    context: Context,
    listener: ItemClickListener
) :
    RecyclerView.Adapter<CurrencyCodeAdapter.ViewHolder>(), Filterable {
    val currencyList: List<Country> = currencyList
    var currencyFilterList: List<Country> = currencyList
    var type: Int = type
    val listener: ItemClickListener = listener
    var context: Context = context


    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): CurrencyCodeAdapter.ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.row_item_currency, parent, false)

        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: CurrencyCodeAdapter.ViewHolder, position: Int) {
        val model = currencyFilterList[position]

        // sets the image to the imageview from our itemHolder class
        holder.imgFlag.setImageDrawable(model.flag)
        holder.tvCode.text = (model.code)
        holder.tvName.text = (model.name)

        if (model.favorite) {
            holder.imgStar.setImageResource(android.R.drawable.star_on)
        } else {
            holder.imgStar.setImageResource(android.R.drawable.star_off)
        }

        holder.itemLayout.setOnClickListener(View.OnClickListener {
            listener.onItemSelect(model, type)

        })
        // sets the text to the textview from our itemHolder class
//        holder.textView.text = ItemsViewModel.text
    }

    override fun getItemCount(): Int {
        return currencyFilterList.size
    }

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charSearch = constraint.toString()
                currencyFilterList = if (charSearch.isEmpty()) {
                    currencyList
                } else {
                    val resultList = ArrayList<Country>()
                    for (row in currencyList) {
                        if (row.code.lowercase().contains(charSearch.lowercase(Locale.ROOT)) || row.name.lowercase().contains(charSearch.lowercase(Locale.ROOT)) ) {
                            resultList.add(row)
                        }
                    }
                    resultList
                }
                val filterResults = FilterResults()
                filterResults.values = currencyFilterList
                Log.e(javaClass.name, filterResults.values.toString())
                return filterResults
            }

            @Suppress("UNCHECKED_CAST")
            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                Log.e("publishResults", results!!.values.toString())
                currencyFilterList = results?.values as ArrayList<Country>
                notifyDataSetChanged()
            }

        }
    }

    class ViewHolder(ItemView: View) : RecyclerView.ViewHolder(ItemView) {
        val imgFlag: ImageView = itemView.findViewById(R.id.img_flag)
        val tvCode: TextView = itemView.findViewById(R.id.tv_currency_code)
        val tvName: TextView = itemView.findViewById(R.id.tv_country_name)
        val imgStar: ImageView = itemView.findViewById(R.id.img_star)
        val itemLayout: RelativeLayout = itemView.findViewById(R.id.item_layout)
    }


}